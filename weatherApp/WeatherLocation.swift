//
//  WeatherLocation.swift
//  weatherApp
//
//  Created by Troy Cavanagh on 24/4/20.
//  Copyright © 2020 Troy Cavanagh. All rights reserved.
//

import Foundation

class WeatherLocation: Decodable {
    var name: String
    var latitude: Double
    var longitude: Double
    
    init(name: String, latitude: Double, longitude: Double) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
    }
    
   
    
}
