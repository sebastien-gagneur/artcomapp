//
//  NewViewController.swift
//  artcom
//
//  Created by Sébastien Gagneur on 21/06/2015.
//  Copyright (c) 2015 Sébastien Gagneur. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewViewController: UITableViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var unArticle : Article?
    var URL : String?
    var api: APIController = APIController()
    
    var name : String?
    var pass : String?
    var role : String?
    var company : String?
    var number : String?
    var street : String?
    var zip : String?
    var city : String?
    var phone : String?
    var website : String?
    var twitter : String?
    var facebook : String?
    var email : String?
    var nameAuthor : String?
    var passAuthor : String?
    
    @IBOutlet var titleTextField: UITextField!
    
    @IBOutlet var subtitleTextField: UITextField!
    
    @IBOutlet var categoryTextField: UITextField!
    
    @IBOutlet var textTextView: UITextView!
    
    @IBOutlet var rateTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.api.delegate = self
        self.titleTextField.delegate = self
        self.subtitleTextField.delegate = self
        self.categoryTextField.delegate = self
        self.textTextView.delegate = self
        self.rateTextField.delegate = self
        
        unArticle = Article(id: "", title: "", subtitle: "", category: 0, text: "", image: UIImage(), rate: 0, company : "", number: 0, street: "", zip: 0, city: "", phone: "", website: "", twitter: "", facebook: "", email: "", nameAuthor:"", passAuthor : "")
        titleTextField.text = ""
        subtitleTextField.text = ""
        categoryTextField.text = "0"
        textTextView.text = ""
        rateTextField.text = "0"
        
        name = Keychain.get("name")?.description
        pass = Keychain.get("pass")?.description
        role = Keychain.get("role")?.description
        company = Keychain.get("company")?.description
        number = Keychain.get("number")?.description
        street = Keychain.get("street")?.description
        zip = Keychain.get("zip")?.description
        city = Keychain.get("city")?.description
        phone = Keychain.get("phone")?.description
        website = Keychain.get("website")?.description
        twitter = Keychain.get("twitter")?.description
        facebook = Keychain.get("facebook")?.description
        email = Keychain.get("email")?.description
        nameAuthor = Keychain.get("name")?.description
        passAuthor = Keychain.get("pass")?.description
        
        println("role \(role) \(number) \(street) \(zip) \(city) \(phone) \(website) \(twitter) \(facebook) \(email)")
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "GotoArticlesFromNew")
        {
            unArticle!.setTitle(titleTextField.text)
            unArticle!.setSubtitle(subtitleTextField.text)
            if ( categoryTextField.text == "")
            {
                unArticle!.setCategory(0)
            }
            else
            {
                unArticle!.setCategory(categoryTextField.text.toInt()!)
            }
            unArticle!.setText(textTextView.text)
            if ( rateTextField.text == "")
            {
                unArticle!.setRate(0)
            }
            else
            {
                unArticle!.setRate(rateTextField.text.toInt()!)
            }
            // complément
            unArticle!.setCompany(self.company!)
            unArticle!.setNumber(self.number!.toInt()!)
            unArticle!.setStreet(self.street!)
            unArticle!.setZip(self.zip!.toInt()!)
            unArticle!.setCity(self.city!)
            unArticle!.setPhone(self.phone!)
            unArticle!.setWebsite(self.website!)
            unArticle!.setTwitter(self.twitter!)
            unArticle!.setFacebook(self.facebook!)
            unArticle!.setEmail(self.email!)
            unArticle!.setNameAuthor(self.nameAuthor!)
            unArticle!.setPassAuthor(self.passAuthor!)
            
            // CREATION d'un nouvel article
            //L'utilisateur doit être admin ou pro pour créer des articles, l'accès à ce module se fait justement avec un filtrage sur la vue d'avant (ViewController) avec le bouton +
            
            URL = "http://techspeech.alwaysdata.net/apiartcom/artcom/articles/admin/9XTN#ztXmFnWH&/" + name! + "/" + pass! + "/insertarticle"
                
            URL = URL! + "?title=" + unArticle!.getTitle() + "&subtitle=" + unArticle!.getSubtitle()
            URL = URL! + "&categorie=" + String(unArticle!.getCategory())
            URL = URL! + "&text=" + unArticle!.getText()
            URL = URL! + "&image=" + "" + "&rate="
            URL = URL! + String(unArticle!.getRate())
            URL = URL! + "&company=" + unArticle!.getCompany() + "&number=" + String(unArticle!.getNumber()) + "&street=" + unArticle!.getStreet() + "&zip=" + String(unArticle!.getZip())
            URL = URL! + "&city=" + unArticle!.getCity() + "&phone=" + unArticle!.getPhone()
            URL = URL! + "&website=" + unArticle!.getWebsite() + "&twitter=" + unArticle!.getTwitter()
            URL = URL! + "&facebook=" + unArticle!.getFacebook() + "&email=" + unArticle!.getEmail()
            URL = URL! + "&nameauthor=" + unArticle!.getNameAuthor() + "&passauthor=" + unArticle!.getPassAuthor()
            println(URL)
            self.api.PostAPIResultsAsync(URL)
        }
    }
    
}

