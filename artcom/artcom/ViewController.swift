//
//  ViewController.swift
//  artcom
//
//  Created by Sébastien Gagneur on 03/03/2015.
//  Copyright (c) 2015 Sébastien Gagneur. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController : UITableViewController {
    
    
    
     override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        Alamofire.request(.GET, "http://techspeech.alwaysdata.net/apiartcom/artcom/articles/root/QMBD35BEI/seb/seb").responseJSON() {
            (_, _, data, _) in
            let json = JSON(data!)
            println(json)
            let tab = json["articles"][0]["title"]
            println("tab \(tab)")
            let count = json["articles"].array!.count
            println("count : \(count)")
        // créer les objets
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //COUNT
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    //INSERT
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    //DELETE
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
}