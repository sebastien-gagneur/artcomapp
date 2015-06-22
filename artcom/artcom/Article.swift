//
//  Articles.swift
//  artcom
//
//  Created by Sébastien Gagneur on 23/05/2015.
//  Copyright (c) 2015 Sébastien Gagneur. All rights reserved.
//

import UIKit

class Article {
    
    // article de base
    var id : String?
    var title : String?
    var subtitle : String?
    var category : Int?
    var text : String?
    var image : UIImage?
    var rate : Int?
    // complément de l'article pour avoir un détail sur l'auteur
    var company : String?
    var number : Int?
    var street : String?
    var zip :  Int?
    var city : String?
    var phone : String?
    var website : String?
    var twitter : String?
    var facebook : String?
    var email : String?
    
    init(id : String!, title : String!, subtitle : String!, category : Int!, text : String!, image : UIImage!, rate : Int!, company : String!, number : Int!, street : String!, zip : Int!, city : String!, phone : String!, website : String!, twitter : String!, facebook : String!, email : String! ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.category = category
        self.text = text
        self.image = image
        self.rate = rate
        // complément
        self.company = company
        self.number = number
        self.street = street
        self.zip = zip
        self.city = city
        self.phone = phone
        self.website = website
        self.twitter = twitter
        self.facebook = facebook
        self.email = email
    }
    
    // SET
    
    func setId(id : String) {
        self.id = id
    }
    
    func setTitle(title : String) {
        self.title = title
    }
    
    func setSubtitle(subtitle : String) {
        self.subtitle = subtitle
    }
    
    func setCategory(category : Int) {
        self.category = category
    }
    
    func setText(text : String) {
        self.text = text
    }
    
    func setImage(image : UIImage) {
        self.image = image
    }
    
    func setRate(rate : Int) {
        self.rate = rate
    }
    // complément
    func setCompany(company : String) {
        self.company = company
    }
    
    func setNumber(number : Int) {
        self.number = number
    }
    
    func setStreet(street : String) {
        self.street = street
    }
    
    func setZip(zip : Int) {
        self.zip = zip
    }
    
    func setCity(city : String) {
        self.city = city
    }
    
    func setPhone(phone : String) {
        self.phone = phone
    }
    
    func setWebsite(website : String) {
        self.website = website
    }
    
    func setTwitter(twitter : String) {
        self.twitter = twitter
    }
    
    func setFacebook(facebook : String) {
        self.facebook = facebook
    }
    
    func setEmail(email : String) {
        self.email = email
    }

    // GET
    
    func getId() -> String {
        return self.id!
    }
    
    func getTitle() -> String {
        return self.title!
    }
    
    func getSubtitle() -> String {
        return self.subtitle!
    }
    
    func getCategory() -> Int
    {
        if self.category == nil {
            return 0
        }
        else
        {
            return self.category!
        }
    }
    
    func getText() -> String{
        return self.text!
    }
    
    func getImage() -> UIImage {
        if self.image == nil {
            return UIImage()
        }
        else
        {
            return self.image!
        }
    }
    
    func getRate() -> Int {
        if self.rate == nil {
            return 0
        }
        else
        {
            return self.rate!
        }
        
    }
    
    // complément
    func getCompany() -> String {
        return self.company!
    }
    
    func getNumber() -> Int {
        if self.number == nil {
            return 0
        }
        else
        {
            return self.number!
        }
    }
    
    func getStreet() -> String {
        return self.street!
    }
    
    func getZip() ->Int {
        if self.zip == nil {
            return 0
        }
        else
        {
            return self.zip!
        }
    }
    
    func getCity() -> String {
        return self.city!
    }
    
    func getPhone() -> String {
        return self.phone!
    }
    
    func getWebsite() -> String {
        return self.website!
    }
    
    func getTwitter() -> String {
        return self.twitter!
    }
    
    func getFacebook() -> String {
        return self.facebook!
    }
    
    func getEmail() -> String {
        return self.email!
    }

    
    
}
