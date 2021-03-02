//
//  UIView+extension.swift
//  weatherApp
//
//  Created by Troy Cavanagh on 5/5/20.
//  Copyright © 2020 Troy Cavanagh. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func setGradientBackground(colourOne: UIColor, colourTwo: UIColor) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colourOne.cgColor, colourTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0)
        
        layer.insertSublayer(gradientLayer, at: 0)
        
    }
}
