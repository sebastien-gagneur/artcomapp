//
//  SettingViewController.swift
//  artcom
//
//  Created by Sébastien Gagneur on 27/05/2015.
//  Copyright (c) 2015 Sébastien Gagneur. All rights reserved.
//


import UIKit

class SettingViewController: UITableViewController {
    
    
    //    var id: Int?
    //    var name : String?
    //    var email : String?
    //    var password : String?
    //
    //    @IBOutlet var idTextField: UITextField!
    //
    //    @IBOutlet var nameTextField: UITextField!
    //
    //    @IBOutlet var emailTextField: UITextField!
    //
    //    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        idTextField.text = id?.description
        //        nameTextField.text = name
        //        emailTextField.text = email
        //        passwordTextField.text = password
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "save" {
            //            unContact = Contact(nom: nomTextField.text, prenom:prenomTextField.text, adresse: adresseTextField.text, mail : mailTextField.text, photo : UIImage())
        }
        
    }
    
}
