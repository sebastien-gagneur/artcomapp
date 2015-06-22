//
//  User.swift
//  artcom
//
//  Created by Sébastien Gagneur on 12/06/2015.
//  Copyright (c) 2015 Sébastien Gagneur. All rights reserved.
//

import Foundation

class User {
    
    var id : String?
    var name : String?
    var pass : String?
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
    var timestamp : Int?
    var role : String?
    var rate : Int?
    
    init(id : String!, name : String!, pass : String!, company : String!, number : Int!, street : String!, zip : Int!, city : String!, phone : String!, website : String!, twitter : String!, facebook : String!, email : String!, timestamp : Int!, role : String!, rate : Int?) {
        self.id = id
        self.name = name
        self.pass = pass
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
        self.timestamp = timestamp
        self.role = role
        self.rate = rate
    }
    
    func setId(id : String) {
        self.id = id
    }
    
    func setName(name : String) {
        self.name = name
    }
    
    func setPass(pass : String) {
        self.pass = pass
    }
    
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
    
    func setTimestamp(timestamp : Int) {
        self.timestamp = timestamp
    }
    
    func setRole(role : String) {
        self.role = role
    }
    
    func setRate(rate : Int) {
        self.rate = rate
    }
    
    
    
    func getId() -> String {
        return self.id!
    }
    
    func getName() -> String {
        return self.name!
    }
    
    func getPass() -> String {
        return self.pass!
    }
    
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
    
    func getTimestamp() -> Int {
        if self.timestamp == nil {
            return 0
        }
        else
        {
            return self.timestamp!
        }
    }
    
    func getRole() -> String {
        return self.role!
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
    
    
}
