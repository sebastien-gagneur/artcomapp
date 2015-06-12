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
    
    
    @IBOutlet var mapView: MKMapView!
    
    @IBOutlet var dealerTextField: UITextField!
    
    var address : String?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        //locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        //let mk : MKMapItem = MKMapItem()
        //let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        //mk.openInMapsWithLaunchOptions(launchOptions)
        
        //let initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
        
        let location = "42, rue Joseph Claussat, Chamalières, France"
        dealerTextField.text = self.address
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
