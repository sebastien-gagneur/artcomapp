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
    // complément
    var name : String?
    var pass : String?
    var company : String?
    var role : String?
    var number : String?
    var street : String?
    var zip : String?
    var city : String?
    var phone : String?
    var website : String?
    var twitter : String?
    var facebook : String?
    var email : String?
    

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
        let navigationController = segue.destinationViewController as! UINavigationController
        
        //let vc = navigationController.topViewController as! DetailViewController
        
        if segue.identifier == "search" {
            let vc = navigationController.topViewController as! WhereViewController
            println("Search")
            vc.address = self.number! + ","
            vc.address = vc.address! + self.street! + ","
            vc.address = vc.address! + self.zip! + "," + self.city!
            vc.company = self.company!
            vc.website = self.website!
            vc.twitter = self.twitter!
            vc.facebook = self.facebook!
            vc.email = self.email!
            vc.phone = self.phone!
            println("address : \(vc.address) company : \(vc.company)")
            
        }
        
    }
    
}