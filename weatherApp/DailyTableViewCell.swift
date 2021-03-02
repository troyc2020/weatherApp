//
//  DailyTableViewCell.swift
//  weatherApp
//
//  Created by Troy Cavanagh on 2/5/20.
//  Copyright © 2020 Troy Cavanagh. All rights reserved.
//

import UIKit

class DailyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dailyIcon: UIImageView!
    @IBOutlet weak var dailyWeekDay: UILabel!
    @IBOutlet weak var dailyHighLabel: UILabel!
    @IBOutlet weak var dailyLowLabel: UILabel!
    @IBOutlet weak var dailySummaryLabel: UILabel!
    @IBOutlet weak var dailyWindBearing: UILabel!
    @IBOutlet weak var dailyWindSpeed: UILabel!
    
    
    
    var dailyWeatherData: [DailyWeather] = []
    var dailyWeather: DailyWeather! {
        didSet {
            dailyIcon.image = UIImage(named: dailyWeather.dailyIcon)
            dailyWeekDay.text = dailyWeather.dailyWeekday
            dailySummaryLabel.text = dailyWeather.dailySummary
            dailyHighLabel.text = "High:\(dailyWeather.dailyHigh)°c"
            dailyLowLabel.text = "Low:\(dailyWeather.dailyLow)°c"
            dailyWindBearing.text = "W:\(dailyWeather.dailyWindBearing)°"
            dailyWindSpeed.text = "S:\(dailyWeather.dailyWindSpeed)km/h"
        }
    }
}
