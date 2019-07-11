//
//  PokeAnnotation.swift
//  Pokemon Go Clone
//
//  Created by Sahil Dogra on 7/11/19.
//  Copyright © 2019 Sahil Dogra. All rights reserved.
//

import UIKit
import MapKit
class PokeAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var pokemon : Pokemon
    
    init(coord: CLLocationCoordinate2D, pokemon: Pokemon) {
        self.coordinate = coord
        self.pokemon = pokemon
    }
    
}
