//
//  WhereViewController.swift
//  webAPI
//
//  Created by Sébastien Gagneur on 06/03/2015.
//  Copyright (c) 2015 Sébastien Gagneur. All rights reserved.
//



import UIKit
import MapKit

class WhereViewController: UITableViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    @IBOutlet var companyTextField: UITextField!
    

    @IBOutlet var numberTextField: UITextField!
    
    @IBOutlet var streetTextField: UITextField!
    
    @IBOutlet var zipTextField: UITextField!
    
    @IBOutlet var cityTextField: UITextField!
    
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var websiteTextField: UITextField!
    
    @IBOutlet var twitterTextField: UITextField!
    
    @IBOutlet var facebookTextField: UITextField!
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var phoneTextField: UITextField!
    
    var id : String?
//    var titleT : String?
//    var sub : String?
//    var category : Int?
//    var text : String?
//    var rate : Int?
    //complément
    var address : String?
    var name : String?
    var pass : String?
    var role : String?
    var company : String?
    var number : String?
    var street : String?
    var zip : String?
    var city : String?
    var phone : String?
    var website : String?
    var twitter : String?
    var facebook : String?
    var email : String?
    var canUpDate : Bool?
    var nameAuthor : String?
    var passAuthor : String?
   
    var unArticle : Article?
    var URL : String?
    var api: APIController = APIController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        unArticle = Article(id: "", title: "", subtitle: "", category: 0, text: "", image: UIImage(), rate: 0, company : "", number: 0, street: "", zip: 0, city: "", phone: "", website: "", twitter: "", facebook: "", email: "", nameAuthor : "", passAuthor : "")
        
        println("add \(address) \(company)")
        var locationManager = CLLocationManager()
        locationManager.delegate = self
        //locationManager.requestWhenInUseAuthorization()
        //locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        //let mk : MKMapItem = MKMapItem()
        //let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        //mk.openInMapsWithLaunchOptions(launchOptions)
        
        //let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        
        let location = self.address
        companyTextField.text = self.company
        //addressTextField.text = self.address
        numberTextField.text = number
        streetTextField.text = street
        zipTextField.text = zip
        cityTextField.text = city
        
        websiteTextField.text = self.website
        twitterTextField.text = self.twitter
        facebookTextField.text = self.facebook
        emailTextField.text = self.email
        phoneTextField.text = self.phone
        
        if  Keychain.get("role") == "public"
        {
            companyTextField.enabled = false
            //addressTextField.enabled = false
            numberTextField.enabled = false
            streetTextField.enabled = false
            zipTextField.enabled = false
            cityTextField.enabled = false
            websiteTextField.enabled = false
            twitterTextField.enabled = false
            facebookTextField.enabled = false
            emailTextField.enabled = false
            phoneTextField.enabled = false
        }
        
        if  Keychain.get("name") != nameAuthor && Keychain.get("pass") != passAuthor
        {
            companyTextField.enabled = false
            //addressTextField.enabled = false
            numberTextField.enabled = false
            streetTextField.enabled = false
            zipTextField.enabled = false
            cityTextField.enabled = false
            websiteTextField.enabled = false
            twitterTextField.enabled = false
            facebookTextField.enabled = false
            emailTextField.enabled = false
            phoneTextField.enabled = false
        }
        else
        {
            if Keychain.get("role") == "pro" || Keychain.get("role") == "admin"
            {
                if  canUpDate == true
                {
                    companyTextField.enabled = true
                    //addressTextField.enabled = true
                    numberTextField.enabled = true
                    streetTextField.enabled = true
                    zipTextField.enabled = true
                    cityTextField.enabled = true
                    websiteTextField.enabled = true
                    twitterTextField.enabled = true
                    facebookTextField.enabled = true
                    emailTextField.enabled = true
                    phoneTextField.enabled = true

                }
            }
        }
    
        var geocoder:CLGeocoder = CLGeocoder()
        geocoder.geocodeAddressString(location, completionHandler: {(placemarks, error) -> Void in
            
            if((error) != nil){
                
                println("Error", error)
            }
                
            else if let placemark = placemarks?[0] as? CLPlacemark {
                
                var placemark:CLPlacemark = placemarks[0] as! CLPlacemark
                var coordinates:CLLocationCoordinate2D = placemark.location.coordinate
                
                var pointAnnotation:MKPointAnnotation = MKPointAnnotation()
                pointAnnotation.coordinate = coordinates
                pointAnnotation.title = self.company
                
                //let span = MKCoordinateSpanMake(0.05, 0.05)
                let region = MKCoordinateRegion()
                self.mapView?.setRegion(region, animated: true)
                
                
                //self.mapMapWiew.autoresizingMask = UIViewAutoresizing()
                self.mapView?.addAnnotation(pointAnnotation)
                self.mapView?.centerCoordinate = coordinates
                self.mapView?.selectAnnotation(pointAnnotation, animated: true)
        
                
                println("Added annotation to map view")
            }
            
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "GotoViewFromWhere") {
            println("GotoViewFromWhere")
            
           unArticle?.setId(id!)
//            unArticle?.setTitle(titleT!)
//            unArticle?.setSubtitle(sub!)
//            unArticle?.setCategory(category!)
//            unArticle?.setText(text!)
//            unArticle?.setRate(rate!)
            // complément
            unArticle!.setCompany(companyTextField.text)
            if (numberTextField.text == "")
            {
                unArticle!.setNumber(0)
            }
            else
            {
                unArticle!.setNumber(numberTextField.text.toInt()!)
            }
            unArticle!.setStreet(streetTextField.text)
            if zipTextField.text == ""
            {
                unArticle!.setZip(0)
            }
            else
            {
                unArticle!.setZip(zipTextField.text.toInt()!)
            }
            unArticle!.setCity(cityTextField.text)
            unArticle!.setPhone(phoneTextField.text)
            unArticle!.setWebsite(websiteTextField.text)
            unArticle!.setTwitter(twitterTextField.text)
            unArticle!.setFacebook(facebookTextField.text)
            unArticle!.setEmail(emailTextField.text)
            
            
            URL = "http://techspeech.alwaysdata.net/apiartcom/artcom/articles/admin/9XTN#ztXmFnWH&/" + name! + "/" + pass! + "/updatearticles2/"
            
            URL = URL! + unArticle!.getId() + "?company=" + unArticle!.getCompany() + "&number="
            
            URL = URL! + String(unArticle!.getNumber()) + "&street=" + unArticle!.getStreet()
            URL = URL! + "&zip=" + String(unArticle!.getZip()) + "&city=" + unArticle!.getCity()
            URL = URL! + "&phone=" + unArticle!.getPhone() + "&website=" + unArticle!.getWebsite()
            URL = URL! + "&twitter=" + unArticle!.getTwitter() + "&facebook=" + unArticle!.getFacebook()
            URL = URL! + "&email=" + unArticle!.getEmail()
            println(URL)
            self.api.PutAPIResultsAsync(URL)
        }
        
    }
    
}
