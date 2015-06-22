//
//  AuthViewController.swift
//  artcom
//
//  Created by Sébastien Gagneur on 11/06/2015.
//  Copyright (c) 2015 Sébastien Gagneur. All rights reserved.
//

import Foundation

import UIKit
import SwiftyJSON

class AuthViewController : UIViewController, APIControllerProtocol, UITextFieldDelegate {
    
    
    var pass : String?
    var name : String?
    var api: APIController = APIController()
    var Auth : Int = 0
    var actInd : UIActivityIndicatorView?

    
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var passTextField: UITextField!
    @IBOutlet var logButton: UIButton!
    @IBOutlet var signButton: UIButton!
    
    
    @IBAction func clickLogButton(sender: UIButton) {
        actInd = UIActivityIndicatorView()
        name = nameTextField.text
        pass = passTextField.text
        self.api.delegate = self
        var URL : String?
        URL = "http://techspeech.alwaysdata.net/apiartcom/artcom/users/root/QMBD35BEI/" + name!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) + "/" + pass!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) + "/auth"
        println("URL \(URL) ")
        self.api.GetAPIResultsAsync(URL)
        shouldPerformSegueWithIdentifier("Verify", sender: self) // appel la méthode suivante qui renvoie faux
        // empêche l'exécution du segue associé au bouton log in
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        return false
        // le segue n'est pas exécuté pour l'instant
    }
    
    @IBAction func clickSignButton(sender: UIButton) {
        // DAns le cas ou le compte public n'existe pas
        // on va dire que les comptes PRO seront créés à l'avance pour les souscriptions
        Keychain.set("name", value: "")
        Keychain.set("pass",value: "")
        Keychain.set("company",value: "")
        Keychain.set("role",value: "")
        Keychain.set("number",value: "")
        Keychain.set("street",value: "")
        Keychain.set("zip",value: "")
        Keychain.set("city",value: "")
        Keychain.set("phone",value: "")
        Keychain.set("website",value: "")
        Keychain.set("twitter",value: "")
        Keychain.set("facebook",value: "")
        Keychain.set("email",value: "")
        performSegueWithIdentifier("SignIn", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameTextField.delegate = self
        self.passTextField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        //super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

    func JSONAPIResults(results: JSON) {
        Auth = results["answerAuth"].intValue
        let role = results["role"].string as String?
        println("role auth \(role)")
        println("Auth \(Auth)")
        if (Auth == 1 ) {
            Keychain.set("name", value: self.name!)
            Keychain.set("pass",value: self.pass!)
            Keychain.set("company",value: results["company"].string!)
            Keychain.set("role",value: results["role"].string!)
            Keychain.set("number",value: (results["number"].int!).description)
            Keychain.set("street",value: results["street"].string!)
            Keychain.set("zip",value: (results["zip"].int!).description)
            Keychain.set("city",value: results["city"].string!)
            Keychain.set("phone",value: results["phone"].string!)
            Keychain.set("website",value: results["website"].string!)
            Keychain.set("twitter",value: results["twitter"].string!)
            Keychain.set("facebook",value: results["facebook"].string!)
            Keychain.set("email",value: results["email"].string!)
            
            performSegueWithIdentifier("Verify", sender: self)
            // le segue est enfin exécuté
        }
        else
        {
            let alertController = UIAlertController(title: "Something goes wrong !", message:
                "Please verify your username or password !", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            Keychain.set("name", value: "")
            Keychain.set("pass",value: "")
            Keychain.set("company", value: "")
            Keychain.set("role",value: "")
            Keychain.set("number",value: "")
            Keychain.set("street",value: "")
            Keychain.set("zip",value: "")
            Keychain.set("city",value: "")
            Keychain.set("phone",value: "")
            Keychain.set("website",value: "")
            Keychain.set("twitter",value: "")
            Keychain.set("facebook",value: "")
            Keychain.set("email",value: "")
        }
    }
    
}