//
//  ViewController.swift
//  Locator
//
//  Created by Luca Scutigliani on 13/07/17.
//  Copyright © 2017 Scutigliani Luca. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager = CLLocationManager()
    var startLocation: CLLocation!
    
    var newLocation: CLLocation!
    var currentLocation : CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
        
        showUserLocation(sender: self)
        
        let when = DispatchTime.now() + 2
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            _ = self.locate()
            
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didFailWithError error: Error) {
        
        print(error)
        
    }
    
    func showUserLocation(sender : AnyObject) {
        let status = CLLocationManager.authorizationStatus()
        
        //Asking for authorization to display current location
        if status == CLAuthorizationStatus.notDetermined {
            locationManager.requestWhenInUseAuthorization()
        } else {
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        
        let latestLocation: CLLocation = locations[locations.count - 1]
        
        currentLocation = latestLocation.coordinate
        
        let zoomRegion : MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(currentLocation, 500, 500)
        
        mapView!.setRegion(zoomRegion, animated: true)
        
    }
    
    
    func locate() {
        
        let currentAnnotation : MKPointAnnotation = MKPointAnnotation()
        
        currentAnnotation.coordinate = currentLocation
        
        currentAnnotation.title = "Sei qui!"
        
        mapView!.addAnnotation(currentAnnotation)
        
        mapView!.selectAnnotation(currentAnnotation, animated: true)
        
    }
    
}

