//
//  ForecastModel.swift
//  weatherApp
//
//  Created by Troy Cavanagh on 27/4/20.
//  Copyright © 2020 Troy Cavanagh. All rights reserved.
//

import Foundation

class Forecast: Codable {
    var name: String
    
    init (name: String) {
        self.name = name
        
    }
    
}


