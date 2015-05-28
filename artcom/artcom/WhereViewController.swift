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
    
    
    @IBOutlet var dealerTextField: UITextField!
    //    var id: Int?
    //    var name : String?
    //    var email : String?
    //    var password : String?
    //
    //    @IBOutlet var idTextField: UITextField!
    //
    //    @IBOutlet var nameTextField: UITextField!
    //
    //    @IBOutlet var emailTextField: UITextField!
    //
    //    @IBOutlet var passwordTextField: UITextField!
    
    
    @IBOutlet var mapMapWiew: MKMapView!
    @IBOutlet var mapMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        //locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        //let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        
        let location = "36, rue Joseph Claussat, Chamalières, France"
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
                pointAnnotation.title = "Etelka Spa"
                
                //self.mapMapWiew.autoresizingMask = UIViewAutoresizing()
                self.mapMapView?.addAnnotation(pointAnnotation)
                self.mapMapView?.centerCoordinate = coordinates
                self.mapMapWiew?.selectAnnotation(pointAnnotation, animated: true)
                
                println("Added annotation to map view")
            }
            
        })
        
        //        idTextField.text = id?.description
        //        nameTextField.text = name
        //        emailTextField.text = email
        //        passwordTextField.text = password
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        manager.requestWhenInUseAuthorization()
        manager.requestAlwaysAuthorization()
        manager.startUpdatingLocation()
        
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if (status == CLAuthorizationStatus.AuthorizedAlways || status == CLAuthorizationStatus.AuthorizedWhenInUse) {
            self.mapMapWiew.showsUserLocation = true
        }
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
