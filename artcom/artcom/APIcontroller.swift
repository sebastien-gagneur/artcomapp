//
//  APIcontroller.swift
//  webAPI
//
//  Created by Sébastien Gagneur on 03/03/2015.
//  Copyright (c) 2015 Sébastien Gagneur. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON

//This defines a protocol that will be implemented in our ViewControler and will receive the results once the API call has completed.
protocol APIControllerProtocol {
    func JSONAPIResults(results: JSON)
}

class APIController : NSObject {
    
    var delegate:APIControllerProtocol?
    
    func GetAPIResultsAsync(URIString:String?) {
        println("API")
        
        
        Alamofire.request(.GET, URIString!).responseJSON() {
            (_, _, data, _) in
            let json = JSON(data!)
            self.delegate?.JSONAPIResults(json)
            println("JSON")
            }
    }
}
