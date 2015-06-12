//
//  SettingViewController.swift
//  artcom
//
//  Created by Sébastien Gagneur on 27/05/2015.
//  Copyright (c) 2015 Sébastien Gagneur. All rights reserved.
//


import UIKit
//import Alamofire
import SwiftyJSON

class SettingViewController: UITableViewController, APIControllerProtocol, UITextFieldDelegate {
    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var passTextField: UITextField!
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
    
    var unUser : User?
    var URL : String?
    
    var api: APIController = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = Keychain.get("name")?.description
        passTextField.text = Keychain.get("pass")?.description
        self.api.delegate = self
        URL = "http://techspeech.alwaysdata.net/apiartcom/artcom/users/root/QMBD35BEI/" + nameTextField.text + "/" + passTextField.text + "/user/" + nameTextField.text
        self.api.GetAPIResultsAsync(URL)
        println(URL)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @IBAction func clickDoneButton(sender: UIBarButtonItem) {
        unUser!.setNumber(numberTextField.text.toInt()!)
        unUser!.setStreet(streetTextField.text)
        unUser!.setZip(zipTextField.text.toInt()!)
        unUser!.setCity(cityTextField.text)
        unUser!.setPhone(phoneTextField.text)
        unUser!.setWebsite(webTextField.text)
        unUser!.setTwitter(twitterTextField.text)
        unUser!.setFacebook(facebookTextField.text)
        unUser!.setEmail(emailTextField.text)
        unUser!.setRole(roleTextField.text)
        unUser!.setRate(rateTextField.text.toInt()!)
        
        URL = "http://techspeech.alwaysdata.net/apiartcom/artcom/users/admin/9XTN#ztXmFnWH&/seb/seb/updateusers/"
        URL = URL! + unUser!.getId() + "?name=seb&password=seb&number=" + String(unUser!.getNumber())
        URL = URL! + "&street=" + unUser!.getStreet()
        URL = URL! + "&zip=" + String(unUser!.getZip()) + "&city=" + unUser!.getCity() + "&phone=" + unUser!.getPhone()
        URL = URL! + "&website=" + unUser!.getWebsite() + "&twitter=" + unUser!.getTwitter() + "&facebook=" + unUser!.getFacebook() + "&email=" + unUser!.getEmail() + "&role=" + unUser!.getRole() + "&rate=" + String(unUser!.getRate())
        println(URL)
        self.api.PutAPIResultsAsync(URL)

    }
    
    func JSONAPIResults(results: JSON) {
        
            let _id = results["_id"]
            let id = _id["$id"]
            let name = results["name"]
            let pass = results["pass"]
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
            let role = results["role"]
            let rate = results["rate"]
        
            unUser = User(id :id.string,name : name.string,pass : pass.string,number : number.int,street : street.string,zip : zip.int,city : city.string,phone : phone.string, website : website.string, twitter : twitter.string, facebook : facebook.string, email : email.string, timestamp : timestamp.int, role : role.string, rate : rate.int)
        
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
