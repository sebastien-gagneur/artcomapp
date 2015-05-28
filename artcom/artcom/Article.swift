//
//  Articles.swift
//  artcom
//
//  Created by Sébastien Gagneur on 23/05/2015.
//  Copyright (c) 2015 Sébastien Gagneur. All rights reserved.
//

import UIKit

class Article {
    
    var id : String?
    var title : String?
    var subtitle : String?
    var category : Int?
    var text : String?
    var image : UIImage?
    var rate : Int?
    
    init(id : String!, title : String!, subtitle : String!, category : Int!, text : String!, image : UIImage!, rate : Int!) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.category = category
        self.text = text
        self.image = image
        self.rate = rate
        
    }
    
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
    
    
}
