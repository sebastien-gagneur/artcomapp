//
//  AuthViewController.swift
//  artcom
//
//  Created by Sébastien Gagneur on 11/06/2015.
//  Copyright (c) 2015 Sébastien Gagneur. All rights reserved.
//

import Foundation

import UIKit
import Alamofire
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
        URL = "http://techspeech.alwaysdata.net/apiartcom/artcom/articles/root/QMBD35BEI/" + name!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) + "/" + pass!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()) + "/auth"
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
        println("Auth \(Auth)")
        if (Auth == 1 ) {
            Keychain.set("name", value: self.name!)
            Keychain.set("pass",value: self.pass!)
            performSegueWithIdentifier("Verify", sender: self)
            // le segue est enfin exécuté
        }
        else
        {
            let alertController = UIAlertController(title: "Something goes wrong !", message:
                "Please verify your username or password !", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
}