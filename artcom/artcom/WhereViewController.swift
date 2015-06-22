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
    
    @IBOutlet var addressTextField: UITextField!
    
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var websiteTextField: UITextField!
    
    @IBOutlet var twitterTextField: UITextField!
    
    @IBOutlet var facebookTextField: UITextField!
    
    @IBOutlet var emailTextField: UITextField!
    
    @IBOutlet var phoneTextField: UITextField!
    
    
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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        println("add \(address) \(company)")
        var locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        //locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        //let mk : MKMapItem = MKMapItem()
        //let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        //mk.openInMapsWithLaunchOptions(launchOptions)
        
        //let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        
        let location = self.address
        companyTextField.text = self.company
        addressTextField.text = self.address
        websiteTextField.text = self.website
        twitterTextField.text = self.twitter
        facebookTextField.text = self.facebook
        emailTextField.text = self.email
        phoneTextField.text = self.phone
        
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
        if segue.identifier == "save" {
            //            unContact = Contact(nom: nomTextField.text, prenom:prenomTextField.text, adresse: adresseTextField.text, mail : mailTextField.text, photo : UIImage())
        }
        
    }
    
}
