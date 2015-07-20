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
        println(Keychain.get("name")?.description)
        println(Keychain.get("pass")?.description)
        println(Keychain.get("role")?.description)
        
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
        println("CanRate")
        Keychain.set("CanRate",value : "1")
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
                vc.id = obj?.getId()
                //vc.indice = indexPath!.row
                vc.titre = obj?.getTitle()
                vc.subtitle = obj?.getSubtitle()
                vc.text = obj?.getText()
                vc.rate = obj?.getRate()
                vc.category = obj?.getCategory()
                vc.nameAuthor = obj?.getNameAuthor()
                vc.passAuthor = obj?.getPassAuthor()
                
                vc.name = Keychain.get("name")?.description
                vc.pass = Keychain.get("pass")?.description
                vc.company = obj?.getCompany() //Keychain.get("company")?.description
                vc.role = Keychain.get("role")?.description
                vc.number = obj?.getNumber() //  Keychain.get("number")?.description
                vc.street = obj?.getStreet() //Keychain.get("street")?.description
                vc.zip = obj?.getZip() //Keychain.get("zip")?.description
                vc.city = obj?.getCity() //Keychain.get("city")?.description
                vc.phone = obj?.getPhone() //Keychain.get("phone")?.description
                vc.website = obj?.getWebsite() //Keychain.get("website")?.description
                vc.twitter = obj?.getTwitter() //Keychain.get("twitter")?.description
                vc.facebook = obj?.getFacebook() ///Keychain.get("facebook")?.description
                vc.email = obj?.getEmail() //Keychain.get("email")?.description
                vc.CanRate = Keychain.get("CanRate")?.description
            }
            
            if segue.identifier == "NewArticle" {
                println("new")
            }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        var answer : Bool?
        if (identifier == "NewArticle") {
            println("should")
            let v = Keychain.get("role")?.description
            if Keychain.get("role")?.description == "admin" || Keychain.get("role")?.description == "pro" {
                println("oui : \(v)")
                answer = true
            }
            else
            {
                println("non : \(v)")
                let alertController = UIAlertController(title: "Something goes wrong !", message:
                    "Only admin or pro roles can create articles. Please subscribe a premium account at contact@techspeech.fr", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil))
                self.presentViewController(alertController, animated: true, completion: nil)
                answer = false
            }
        }
        if (identifier == "Settings") {
            answer = true
        }
        return answer!
    }
    
    
    func JSONAPIResults(results: JSON) {
        
        self.countArticles = results["articles"].array!.count
        //var unArticle : Article?
        for var i = 0 ; i < self.countArticles; i++ {
            let _id = results["articles"][i]["_id"]
            let id = _id["$id"]
            let title = results["articles"][i]["title"]
            let subtitle = results["articles"][i]["subtitle"]
            let category = results["articles"][i]["category"]
            let text = results["articles"][i]["text"]
            let rate = results["articles"][i]["rate"]
            // complément
            let company = results["articles"][i]["company"]
            let number = results["articles"][i]["number"]
            let street = results["articles"][i]["street"]
            let zip = results["articles"][i]["zip"]
            let city = results["articles"][i]["city"]
            let phone = results["articles"][i]["phone"]
            let website = results["articles"][i]["website"]
            let twitter = results["articles"][i]["twitter"]
            let facebook = results["articles"][i]["facebook"]
            let email = results["articles"][i]["email"]
            let nameA = results["articles"][i]["nameauthor"]
            let passA = results["articles"][i]["passauthor"]
            
            
            //self.unArticle = Article(id :id.string,title : title.string,subtitle : subtitle.string,category : category.int,text : text.string,image : UIImage(),rate : rate.int)
            self.unArticle = Article(id: id.string, title: title.string, subtitle: subtitle.string, category: category.int, text: text.string, image: UIImage(), rate: rate.int, company : company.string, number: number.int, street: street.string, zip: zip.int, city: city.string, phone: phone.string, website: website.string, twitter: twitter.string, facebook: facebook.string, email: email.string, nameAuthor : nameA.string, passAuthor : passA.string)
            
            self.tableArticles.insert(self.unArticle!,atIndex: i)
        }
//        println("oioioioi :\(tableArticles.count)")
//        for var i = 0 ; i < self.countArticles; i++ {
//        
//            println("table : \(self.tableArticles[i]?.getId())")
//        }
        tableView.reloadData()
    }
}
