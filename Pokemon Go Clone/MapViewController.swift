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
    var pokemons : [Pokemon] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pokemons = getAllPokemon()
        
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
        
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { (timer) in
            if let center = self.manager.location?.coordinate{
                var annoCoord = center
                annoCoord.latitude += (Double.random(in: 0...200) - 100.0) / 30000.0
                annoCoord.longitude += (Double.random(in: 0...200) - 100.0) / 30000.0
                if let pokemon = self.pokemons.randomElement(){
                    let anno = PokeAnnotation(coord: annoCoord, pokemon: pokemon)
                    self.mapView.addAnnotation(anno)
                }
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let annoView = MKAnnotationView(annotation: annotation, reuseIdentifier: nil)
        if (annotation is MKUserLocation){
            annoView.image = UIImage(named: "player")
            
        }
        else{
            if let pokeAnnotation = annotation as? PokeAnnotation {
                if let imageName = pokeAnnotation.pokemon.imageName{
                    annoView.image = UIImage(named: imageName)
                }
            }
        }
        var frame = annoView.frame
        frame.size.height = 50.0
        frame.size.width = 50.0
        annoView.frame = frame
        
        return annoView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        mapView.deselectAnnotation(view.annotation, animated: true)
        if (view.annotation is MKUserLocation){
            //This is the user
        }
        else {
            if let center = manager.location?.coordinate{
                if let pokeCenter = view.annotation?.coordinate{
                    let region = MKCoordinateRegion(center: pokeCenter, latitudinalMeters: 200, longitudinalMeters: 200)
                    mapView.setRegion(region, animated: false)
                    
                    if let pokeAnnotation = view.annotation as? PokeAnnotation{
                        if let pokemonName = pokeAnnotation.pokemon.name {
                            if mapView.visibleMapRect.contains(MKMapPoint(center)){
                                
                                //Caught!
                                pokeAnnotation.pokemon.caught = true
                                (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
                                
                                let alertVC = UIAlertController(title: "Congratulations!", message: "You caught a \(pokemonName)", preferredStyle: .alert)
                                let pokeDexAction = UIAlertAction(title: "PokeDex", style: .default){ (action) in
                                    self.performSegue(withIdentifier: "moveToPokedex", sender: nil)
                                }
                                let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                                alertVC.addAction(pokeDexAction)
                                alertVC.addAction(okAction)
                                present(alertVC, animated: true, completion: nil)
                                
                            }
                            else{
                                //Too far to catch
                                let alertVC = UIAlertController(title: "Oops!", message: "You were too far from \(pokemonName). Try moving closer!", preferredStyle: .alert)
                                
                                let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                                
                                alertVC.addAction(okAction)
                                present(alertVC, animated: true, completion: nil)
                            }
                        }
                        
                    }
                }
            }
        }
        
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
