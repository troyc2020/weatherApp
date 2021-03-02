//
//  ForecastSelectViewController.swift
//  weatherApp
//
//  Created by Troy Cavanagh on 26/4/20.
//  Copyright © 2020 Troy Cavanagh. All rights reserved.
//

import UIKit

class ForecastSelectViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherButton: UIButton!
    @IBOutlet weak var twentyFourHourButton: UIButton!
    @IBOutlet weak var sevenDayWeather: UIButton!
    
    
    
    
    var weatherDetail: WeatherDetail!
    var weatherLocation: WeatherLocation!
    var weatherLocations: [WeatherLocation] = []
    
    var forecast: Forecast!
    var forecasts: [Forecast] = []
    var dailyWeather: DailyWeather!
    var dailyWeatherData: [DailyWeather] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentWeatherButton.layer.cornerRadius = 15.0
        twentyFourHourButton.layer.cornerRadius = 15.0
        sevenDayWeather.layer.cornerRadius = 15.0

       updateUI()
        
        
    }
    
    
    @IBAction func currentWeatherPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "currentSeque", sender: self)
}
    
    @IBAction func twentyFourHourPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "twentyFourHour", sender: self)
    }

    @IBAction func sevenDayPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "sevenDaySeque", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "currentSeque" {
        let name = segue.destination as! LocationDetailViewController
        name.weatherLocation = self.weatherLocation
      } else {
            if segue.identifier == "twentyFourHour" {
         let name = segue.destination as! TwentyFourHourViewController
        name.weatherLocation = self.weatherLocation
    } else {
         if segue.identifier == "sevenDaySeque" {
         let name = segue.destination as! WeeklyForecastViewController
         name.weatherLocation = self.weatherLocation
    }
    }
    }
    }
    
    func updateUI(){
        locationLabel.text = weatherLocation.name
}
        
}

        
        
        
        

    

    
    
    


