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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        if (annotation is MKUserLocation){
            annoView.image = UIImage(named: "player")
            var frame = annoView.frame
            frame.size.height = 50.0
            frame.size.width = 50.0
            annoView.frame = frame
        }
        return annoView
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (updateCount < 3) {
            if let center = manager.location?.coordinate {
                let region = MKCoordinateRegion(center: center, latitudinalMeters: 200, longitudinalMeters: 200)
                mapView.setRegion(region, animated: false)
            }
            updateCount += 1
        }
        else {
            manager.stopUpdatingLocation()
        }
        
        
    }
    
    @IBAction func centerTapped(_ sender: Any) {
        if let center = manager.location?.coordinate {
            let region = MKCoordinateRegion(center: center, latitudinalMeters: 200, longitudinalMeters: 200)
            mapView.setRegion(region, animated: true)
        }
    }
    
}
