//
//  ViewController.swift
//  artcom
//
//  Created by Sébastien Gagneur on 03/03/2015.
//  Copyright (c) 2015 Sébastien Gagneur. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController : UITableViewController, APIControllerProtocol {
    
    var tableArticles : Array<Article?> = []
    var countArticles : Int?
    var unArticle : Article?
    var api: APIController = APIController()
    var actInd : UIActivityIndicatorView?
    
     override func viewDidLoad() {
        super.viewDidLoad()
        actInd = UIActivityIndicatorView()
        self.api.delegate = self
        self.api.GetAPIResultsAsync("http://techspeech.alwaysdata.net/apiartcom/artcom/articles/root/QMBD35BEI/seb/seb")
        actInd = UIActivityIndicatorView(frame: CGRectMake(0,0, 50, 50)) as UIActivityIndicatorView
        actInd!.center = self.view.center
        actInd!.hidesWhenStopped = true
        actInd!.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.Gray
        view.addSubview(actInd!)
        actInd!.startAnimating()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //COUNT
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArticles.count
    }
    
    //INSERT
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        actInd!.stopAnimating()
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "cellArticles")
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = tableArticles[indexPath.row]!.getTitle()
        cell.detailTextLabel?.text = tableArticles[indexPath.row]!.getSubtitle() + " " +  tableArticles[indexPath.row]!.getText()
        return cell
    }
    
    //DELETE
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
                
                let indice = indexPath.row
        }

        
    }
    
    //Sélection de la ligne de la tableView
    // gestion du Segue sur le disclosure qui ne marche par défaut
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow();
        let currentCell = tableView.cellForRowAtIndexPath(indexPath!) as UITableViewCell!;
        self.performSegueWithIdentifier("Details", sender: currentCell)
        // lancement du segue Details dans le prepareForSegue
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue,
        sender: AnyObject!) {
            //In your case destination controller is navigation controller not your InformationsViewController
            let navigationController = segue.destinationViewController as! UINavigationController
    
            if segue.identifier == "Details" {
                let vc = navigationController.topViewController as! DetailViewController
                // sender is the tapped `UITableViewCell`
                let cell = sender as! UITableViewCell
                let indexPath = self.tableView.indexPathForCell(cell)
                //index value
                //let indice = indexPath!.row
                let obj = tableArticles[indexPath!.row]
                vc.titre = obj?.getTitle()
                vc.subtitle = obj?.getSubtitle()
                vc.text = obj?.getText()
                vc.rate = obj?.getRate()
                vc.category = obj?.getCategory()
            }
    }
    
                
                
    
    
    func JSONAPIResults(results: JSON) {
        
        self.countArticles = results["articles"].array!.count
        //var unArticle : Article?
        for var i = 0 ; i < self.countArticles; i++ {
            let id = results["articles"][i]["_id"]
            let title = results["articles"][i]["title"]
            let subtitle = results["articles"][i]["subtitle"]
            let category = results["articles"][i]["category"]
            let text = results["articles"][i]["text"]
            let rate = results["articles"][i]["rate"]
            
            self.unArticle = Article(id :id.string,title : title.string,subtitle : subtitle.string,category : category.int,text : text.string,image : UIImage(),rate : rate.int)
            self.tableArticles.insert(self.unArticle!,atIndex: i)
        }
//        println("oioioioi :\(tableArticles.count)")
//        for var i = 0 ; i < self.countArticles; i++ {
//            
//            println("table : \(self.tableArticles[i]?.getText())")
//        }
        tableView.reloadData()
    }
}
