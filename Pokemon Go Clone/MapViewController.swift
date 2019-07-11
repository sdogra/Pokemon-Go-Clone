//
//  MapViewController.swift
//  Pokemon Go Clone
//
//  Created by Sahil Dogra on 7/11/19.
//  Copyright © 2019 Sahil Dogra. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!
    var manager = CLLocationManager()
    var updateCount = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        if (CLLocationManager.authorizationStatus() == .authorizedWhenInUse){
            setup();
        }
        else{
            manager.requestWhenInUseAuthorization()
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if (status == .authorizedWhenInUse){
            setup()
        }
    }
    
    func setup() {
        mapView.showsUserLocation = true
        manager.startUpdatingLocation()
        mapView.delegate = self
    }
    
    @IBAction func centerTapped(_ sender: Any) {
    }
    
}
