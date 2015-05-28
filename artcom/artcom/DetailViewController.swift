//
//  DetailViewController.swift
//  webAPI
//
//  Created by Sébastien Gagneur on 06/03/2015.
//  Copyright (c) 2015 Sébastien Gagneur. All rights reserved.
//


import UIKit

class DetailViewController: UITableViewController {
    
    
    var titre: String?
    var subtitle : String?
    var category : Int?
    var text : String?
    var rate : Int?

    @IBOutlet var titleTextField: UITextField!
    
    @IBOutlet var subtitleTextField: UITextField!
    
    @IBOutlet var categoryTextField: UITextField!
    
    @IBOutlet var textTextView: UITextView!
    
    @IBOutlet var rateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        println(titre)
        titleTextField.text = titre
        subtitleTextField.text = subtitle
        categoryTextField.text = self.category?.description
        textTextView.text = text
        println(text)
        rateTextField.text = self.rate?.description
        
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