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
    
    // CALL GET API
    func GetAPIResultsAsync(URIString:String?) {
        println("GET API")
        Alamofire.request(.GET, URIString!).responseJSON() {
            (_, _, data, _) in
            let json = JSON(data!)
            self.delegate?.JSONAPIResults(json)
            println("JSON")
            }
    }
    
    //CALL PUT API
    func PutAPIResultsAsync(URIString:String?) {
        println("PUT API")
        var urlString : String?
        urlString = URIString
        urlString = urlString!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        Alamofire.request(.PUT,urlString!, parameters: nil, encoding : .URL ).responseString { (request, response, data, error) in
                println("REQUEST : \(request)")
                println("RESPONSE : \(response)")
                println("DATA \(data)") // permet d'afficher le message d'erreur en remplaçant .response... par .responseString
                println("ERROR : \(error)")
            }
    }
    
    //CALL POST API
    func PostAPIResultsAsync(URIString:String?) {
        println("POST API")
        var urlString : String?
        urlString = URIString
        urlString = urlString!.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        Alamofire.request(.POST,urlString!, parameters: nil, encoding : .URL ).responseString { (request, response, data, error) in
            println("REQUEST : \(request)")
            println("RESPONSE : \(response)")
            println("DATA \(data)") // permet d'afficher le message d'erreur en remplaçant .response... par .responseString
            println("ERROR : \(error)")
        }
    }
    
    
    
}
