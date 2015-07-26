//
//  DetailViewController.swift
//  webAPI
//
//  Created by Sébastien Gagneur on 06/03/2015.
//  Copyright (c) 2015 Sébastien Gagneur. All rights reserved.
//


import UIKit

class DetailViewController: UITableViewController {
    
    var id : String?
    //var indice : Int?
    var titre: String?
    var subtitle : String?
    var category : Int?
    var text : String?
    var rate : Int?
    var nameAuthor : String?
    var passAuthor : String?
    // complément
    var name : String?
    var pass : String?
    var company : String?
    var role : String?
    var number : Int?
    var street : String?
    var zip : Int?
    var city : String?
    var phone : String?
    var website : String?
    var twitter : String?
    var facebook : String?
    var email : String?
    var CanRate : String?
    
    var unArticle : Article?
    var URL : String?
    var canUpDateWhereView : Bool?
    
    var api: APIController = APIController()

    

    @IBOutlet var titleTextField: UITextField!
    
    @IBOutlet var subtitleTextField: UITextField!
    
    @IBOutlet var categoryTextField: UITextField!
    
    @IBOutlet var textTextView: UITextView!
    
    @IBOutlet var rateTextField: UITextField!
    
    @IBAction func RateItButton(sender: UIButton) {
        println("rate it +1")
        
        if CanRate == "1"
        {
            var value : Int?
            value = rateTextField.text.toInt()
            value = value! + 1
            rateTextField.text = String(stringInterpolationSegment: value!)
            CanRate = "0"
            Keychain.set("CanRate", value: "0")
        }
       
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unArticle = Article(id: "", title: "", subtitle: "", category: 0, text: "", image: UIImage(), rate: 0, company : "", number: 0, street: "", zip: 0, city: "", phone: "", website: "", twitter: "", facebook: "", email: "", nameAuthor : "", passAuthor : "")
        
//        name = Keychain.get("name")?.description
//        pass = Keychain.get("pass")?.description
//        role = Keychain.get("role")?.description
//        company = Keychain.get("company")?.description
//        number = Keychain.get("number")?.description
//        street = Keychain.get("street")?.description
//        zip = Keychain.get("zip")?.description
//        city = Keychain.get("city")?.description
//        phone = Keychain.get("phone")?.description
//        website = Keychain.get("website")?.description
//        twitter = Keychain.get("twitter")?.description
//        facebook = Keychain.get("facebook")?.description
//        email = Keychain.get("email")?.description
        canUpDateWhereView = false

        
        
        println(titre)
        titleTextField.text = titre
        subtitleTextField.text = subtitle
        categoryTextField.text = self.category?.description
        textTextView.text = text
        println(text)
        rateTextField.text = self.rate?.description
        rateTextField.enabled = false
        
        // Je vérifie que le rôle de l'utilisateur connecté permet ou pas d'accéder aux champs.
        // NON pour un compte publique
        if  Keychain.get("role") == "public"
        {
            titleTextField.enabled = false
            subtitleTextField.enabled = false
            categoryTextField.enabled = false
            textTextView.editable = false
        }
        
        // Je vérifie que le name et pass de l'utilisateur connecté, correspond à celle de l'utilisateur qui a créé l'annonce
        if  Keychain.get("name") != nameAuthor && Keychain.get("pass") != passAuthor
        {
            titleTextField.enabled = false
            subtitleTextField.enabled = false
            categoryTextField.enabled = false
            textTextView.editable = false
        }
        else
        {
            if Keychain.get("role") == "pro" || Keychain.get("role") == "admin"
            {
                canUpDateWhereView = true
            }
        }
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
            
           unArticle?.setId(id!)
//            unArticle?.setTitle(titleTextField.text)
//            unArticle?.setSubtitle(subtitleTextField.text)
//            unArticle?.setCategory(categoryTextField.text.toInt()!)
//            unArticle?.setText(textTextView.text)
//            unArticle?.setRate(rateTextField.text.toInt()!)
//            
           vc.id = unArticle?.getId()
//            vc.titleT = unArticle?.getTitle()
//            vc.sub = unArticle?.getSubtitle()
//            vc.category = unArticle?.getCategory()
//            vc.text = unArticle?.getText()
//            vc.rate = unArticle?.getRate()
            // complément
            vc.name = name
            vc.pass = pass
            vc.company = self.company!
            vc.address = self.number!.description + ", "
            vc.address = vc.address! + self.street! + ", "
            vc.address = vc.address! + self.zip!.description + ", " + self.city!
            
            vc.number = self.number?.description
            vc.street = self.street
            vc.zip = self.zip?.description
            vc.city = self.city
            vc.website = self.website!
            vc.twitter = self.twitter!
            vc.facebook = self.facebook!
            vc.email = self.email!
            vc.phone = self.phone!
            vc.canUpDate = canUpDateWhereView
            vc.nameAuthor = nameAuthor
            vc.passAuthor = passAuthor
            
            println("address : \(vc.address) company : \(vc.company) upDate : \(vc.canUpDate)")
            
        }
        
        if (segue.identifier == "GotoArticlesFromDetails") {
            println("GotoArticlesFromDetails")
            
            
            unArticle?.setId(id!)
            unArticle?.setTitle(titleTextField.text)
            unArticle?.setSubtitle(subtitleTextField.text)
            unArticle?.setCategory(categoryTextField.text.toInt()!)
            unArticle?.setText(textTextView.text)
            unArticle?.setRate(rateTextField.text.toInt()!)
            // complément
            unArticle!.setCompany(self.company!)
            unArticle!.setNumber(self.number!)
            unArticle!.setStreet(self.street!)
            unArticle!.setZip(self.zip!)
            unArticle!.setCity(self.city!)
            unArticle!.setPhone(self.phone!)
            unArticle!.setWebsite(self.website!)
            unArticle!.setTwitter(self.twitter!)
            unArticle!.setFacebook(self.facebook!)
            unArticle!.setEmail(self.email!)
            
            URL = "http://techspeech.alwaysdata.net/apiartcom/artcom/articles/admin/9XTN#ztXmFnWH&/" + name! + "/" + pass! + "/updatearticles/"
            
            URL = URL! + unArticle!.getId() + "?title=" + unArticle!.getTitle() + "&subtitle="
            
            URL = URL! + unArticle!.getSubtitle() + "&category=" + String(unArticle!.getCategory())
            URL = URL! + "&text=" + unArticle!.getText() + "&rate=" + String(unArticle!.getRate())
            
            println(URL)
            self.api.PutAPIResultsAsync(URL)
        }
        
    }
    
    
    
}