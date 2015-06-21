//
//  NewViewController.swift
//  artcom
//
//  Created by Sébastien Gagneur on 21/06/2015.
//  Copyright (c) 2015 Sébastien Gagneur. All rights reserved.
//

import UIKit
import SwiftyJSON

class NewViewController: UITableViewController, APIControllerProtocol, UITextFieldDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
       let role = Keychain.get("role")?.description
        println("role \(role)")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func JSONAPIResults(results: JSON) {
    }
    
}

