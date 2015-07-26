//
//  SettingViewController.swift
//  artcom
//
//  Created by Sébastien Gagneur on 27/05/2015.
//  Copyright (c) 2015 Sébastien Gagneur. All rights reserved.
//


import UIKit
import SwiftyJSON

class SettingViewController: UITableViewController, APIControllerProtocol, UITextFieldDelegate {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var passTextField: UITextField!
    @IBOutlet var companyTextField: UITextField!
    @IBOutlet var numberTextField: UITextField!
    @IBOutlet var streetTextField: UITextField!
    @IBOutlet var zipTextField: UITextField!
    @IBOutlet var cityTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var webTextField: UITextField!
    @IBOutlet var twitterTextField: UITextField!
    @IBOutlet var facebookTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var roleTextField: UITextField!
    @IBOutlet var rateTextField: UITextField!
    
    @IBOutlet var cancelButton: UIButton!
    
    var unUser : User?
    var URL : String?
    // point d'entrée dans les settings :
    var SignIn : Bool = false // false : on arrive par le login, true on arrive par le signin
    var execute : Bool?
    
    var nameForSignIn : String?
    var passForSignIn : String?
    
    var api: APIController = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // création d'un compte user à blanc à remplir par la suite
        unUser = User(id :"",name : "",pass : "",company : "", number : 0,street : "",zip : 0,city : "",phone : "", website : "", twitter : "", facebook : "", email : "", timestamp : 0, role : "", rate : 0)
        
        nameTextField.text = Keychain.get("name")?.description
        println("name : \(nameTextField.text)")
        passTextField.text = Keychain.get("pass")?.description
        println("pass : \(passTextField.text)")
        
        //Si les champs sont différents de blanc, l'authentification est déjà faite, on ne peut plus modifier le nom de l'utilisateur
        if (nameTextField.text != "" && passTextField != "")
        {
            nameTextField.enabled = false
        }
        
        self.api.delegate = self
        self.nameTextField.delegate = self
        self.passTextField.delegate = self
        self.companyTextField.delegate = self
        self.numberTextField.delegate = self
        self.streetTextField.delegate = self
        self.zipTextField.delegate = self
        self.cityTextField.delegate = self
        self.phoneTextField.delegate = self
        self.webTextField.delegate = self
        self.twitterTextField.delegate = self
        self.facebookTextField.delegate = self
        self.emailTextField.delegate = self
        self.roleTextField.delegate = self
        self.rateTextField.delegate = self
        
        // Valeur différente de blanc => donc l'authentification est déjà faite
        // je recherche les informations sur l'utilisateur
        if (nameTextField.text != "" && passTextField != "")
        {
            self.cancelButton.hidden = true
            URL = "http://techspeech.alwaysdata.net/apiartcom/artcom/users/root/QMBD35BEI/" + nameTextField.text + "/" + passTextField.text + "/user/" + nameTextField.text
            self.api.GetAPIResultsAsync(URL)
            println(URL)
        }
        // sinon je dois créer un compte
        else
        {
            SignIn = true // on arrive par le sign in
            nameTextField.text = nameForSignIn
            passTextField.text = passForSignIn
            
            let alertController = UIAlertController(title: "NEW ACCOUNT ! You must create your account", message:
                "Fill all fields and press Done. You can CANCEL this operation, PRESS cancel button at the bottom of this view", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        execute = true
        
        if (identifier == "GotoArticles")
        {
            if nameTextField.text == ""
            {
                execute = false
            }
            if passTextField.text == ""
            {
                execute = false
            }
            if companyTextField.text == ""
            {
                execute = false
            }
            if numberTextField.text == "0"
            {
                execute = false
            }
            if streetTextField.text == ""
            {
                execute = false
            }
            if zipTextField.text == "0"
            {
               execute = false
            }
            if cityTextField.text == ""
            {
                execute = false
            }
            if execute == false
            {
            let alertController = UIAlertController(title: "You must fill following fields", message:
                "name, pass, company, number, street, zip, city must be not blank !", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            }
        }
            return execute!
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "GotoArticles")
        {
            unUser!.setName(nameTextField.text)
            unUser!.setPass(passTextField.text)
            unUser!.setCompany(companyTextField.text)
            
            if ( numberTextField.text == "")
            {
                unUser!.setNumber(0)
            }
            else
            {
                unUser!.setNumber(numberTextField.text.toInt()!)
            }
            
            unUser!.setStreet(streetTextField.text)
            if ( zipTextField.text == "")
            {
                unUser!.setZip(0)
            }
            else
            {
                unUser!.setZip(zipTextField.text.toInt()!)
            }
            unUser!.setCity(cityTextField.text)
            unUser!.setPhone(phoneTextField.text)
            unUser!.setWebsite(webTextField.text)
            unUser!.setTwitter(twitterTextField.text)
            unUser!.setFacebook(facebookTextField.text)
            unUser!.setEmail(emailTextField.text)
            // Si création d'un nouveau compte avec sign in
            if (SignIn == true)
            {
                unUser!.setRole("public")
            }
            // pour un compte déjà existant avec log in on reprend le rôle déjà renseigné
            else
            {
                unUser!.setRole(roleTextField.text)
            }
            
            
            if ( rateTextField.text == "")
            {
                unUser!.setRate(0)
            }
            else
            {
                unUser!.setRate(rateTextField.text.toInt()!)
            }
            
            // MISE A JOUR d'un compte existant
            if (SignIn == false)
            {
                // mise à jour normalement le compte du user devrait être utilisé ici !!!!
                println(unUser!.getId())
                URL = "http://techspeech.alwaysdata.net/apiartcom/artcom/users/admin/9XTN#ztXmFnWH&/" + unUser!.getName() + "/" + unUser!.getPass() + "/updateusers/"
                URL = URL! + unUser!.getId() + "?name=" + unUser!.getName() + "&password=" + unUser!.getPass() + "&company=" + unUser!.getCompany() + "&number=" + String(unUser!.getNumber())
                URL = URL! + "&street=" + unUser!.getStreet()
                URL = URL! + "&zip=" + String(unUser!.getZip()) + "&city=" + unUser!.getCity() + "&phone=" + unUser!.getPhone()
                URL = URL! + "&website=" + unUser!.getWebsite() + "&twitter=" + unUser!.getTwitter() + "&facebook=" + unUser!.getFacebook() + "&email=" + unUser!.getEmail() + "&role=" + unUser!.getRole() + "&rate=" + String(unUser!.getRate())
                println(URL)
                self.api.PutAPIResultsAsync(URL)
            }
            // CREATION d'un nouveau compte
            else
            {
                //il doit y avoir au moins deux comptes admin pour créer des comptes
                // admin de base et seb/seb role = admin
                
                URL = "http://techspeech.alwaysdata.net/apiartcom/artcom/users/admin/9XTN#ztXmFnWH&/seb/seb/insertuser"
                URL = URL! + "?name=" + unUser!.getName() + "&password=" + unUser!.getPass() + "&company=" + unUser!.getCompany() + "&number=" + String(unUser!.getNumber())
                URL = URL! + "&street=" + unUser!.getStreet()
                URL = URL! + "&zip=" + String(unUser!.getZip()) + "&city=" + unUser!.getCity() + "&phone=" + unUser!.getPhone()
                URL = URL! + "&website=" + unUser!.getWebsite() + "&twitter=" + unUser!.getTwitter() + "&facebook=" + unUser!.getFacebook() + "&email=" + unUser!.getEmail() + "&role=" + unUser!.getRole() + "&rate=" + String(unUser!.getRate())
                println(URL)
                self.api.PostAPIResultsAsync(URL)
                // une fois le compte créé je remets le flag comme-ci le compte existe maintenant
                SignIn = false
            }
            Keychain.set("name", value: unUser!.getName())
            Keychain.set("pass",value: unUser!.getPass())
            Keychain.set("company",value: unUser!.getCompany())
            Keychain.set("role",value: unUser!.getRole())
            
            Keychain.set("number",value: unUser!.getNumber().description)
            Keychain.set("street",value: unUser!.getStreet())
            Keychain.set("zip",value: unUser!.getZip().description)
            Keychain.set("city",value: unUser!.getCity())
            Keychain.set("phone",value: unUser!.getPhone())
            Keychain.set("website",value: unUser!.getWebsite())
            Keychain.set("twitter",value: unUser!.getTwitter())
            Keychain.set("facebook",value: unUser!.getFacebook())
            Keychain.set("email",value: unUser!.getEmail())

        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // A supprimer ????
    @IBAction func clickDoneButton(sender: UIBarButtonItem) {
        // mise à jour du compte si déjà authentifié, sinon création du compte
        println("DONE")
    }
    
    func JSONAPIResults(results: JSON) {
            // Accès à un User déjà existant et donc authentifié
            println(results)
            let _id = results["_id"]
            let id = _id["$id"]
            let name = results["name"]
            let pass = results["pass"]
            let company = results["company"]
            let number = results["number"]
            let street = results["street"]
            let zip = results["zip"]
            let city = results["city"]
            let phone = results["phone"]
            let website = results["website"]
            let twitter = results["twitter"]
            let facebook = results["facebook"]
            let email = results["email"]
            let timestamp = results["timestamp"]
            let sec = timestamp["sec"]
            let inc = timestamp["inc"]
            let role = results["role"]
            let rate = results["rate"]
        
            unUser!.setId(id.string!)
            unUser!.setName(name.string!)
            unUser!.setPass(pass.string!)
            unUser!.setCompany(company.string!)
            unUser!.setNumber(number.int!)
            unUser!.setStreet(street.string!)
            unUser!.setZip(zip.int!)
            unUser!.setCity(city.string!)
            unUser!.setPhone(phone.string!)
            unUser!.setWebsite(website.string!)
            unUser!.setTwitter(twitter.string!)
            unUser!.setFacebook(facebook.string!)
            unUser!.setEmail(email.string!)
            //unUser!.setTimestamp(timestamp.int!) -> géré par web service à la création
            unUser!.setRole(role.string!)
            unUser!.setRate(rate.int!)

            companyTextField.text = (unUser!.getCompany())
            numberTextField.text = (unUser!.getNumber()).description
            streetTextField.text = unUser!.getStreet()
            zipTextField.text = (unUser!.getZip()).description
            cityTextField.text = unUser!.getCity()
            phoneTextField.text = unUser!.getPhone()
            webTextField.text = unUser!.getWebsite()
            twitterTextField.text = unUser!.getTwitter()
            facebookTextField.text = unUser!.getFacebook()
            emailTextField.text = unUser!.getEmail()
            roleTextField.text = unUser!.getRole()
            rateTextField.text = (unUser!.getRate()).description
    }
    
}
