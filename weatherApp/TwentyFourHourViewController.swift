//
//  TwentyFourHourViewController.swift
//  weatherApp
//
//  Created by Troy Cavanagh on 4/5/20.
//  Copyright © 2020 Troy Cavanagh. All rights reserved.
//

import UIKit
import MessageUI

private let dateFormatter: DateFormatter = {
    print("dateformatter")
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM d"
    return dateFormatter
}()





class TwentyFourHourViewController: UIViewController {
    
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var dailyHighLabel: UILabel!
    @IBOutlet weak var dailyLowLabel: UILabel!
    @IBOutlet weak var windBearingLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var twentyFourHourView: UIView!
    
    
    var weatherDetail: WeatherDetail!
    var weatherLocations: [WeatherLocation] = []
    var weatherLocation: WeatherLocation!
    
    var forecast: Forecast!
    var dailyWeather: DailyWeather!
    var dailyWeatherData: [DailyWeather] = []
    
    var favoriteBarButton: UIBarButtonItem?
    var favorite: Bool = false
    let favoriteBorderImage = UIImage(named: "baseline_favorite_border_black_48pt")?.withRenderingMode(.alwaysTemplate)
    let favoriteFullImage = UIImage(named: "baseline_favorite_black_48pt")?.withRenderingMode(.alwaysTemplate)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
       
        
        
        view.setGradientBackground(colourOne: UIColor.orange, colourTwo: UIColor.lightGray)
        twentyFourHourView.layer.cornerRadius = 10.0
        
        let favoriteButton = UIButton(type: .system)
        favoriteButton.tintColor = .red
        favoriteButton.setImage(self.favoriteBorderImage, for: .normal)
        favoriteButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        self.favoriteBarButton = UIBarButtonItem(customView: favoriteButton)
        self.navigationItem.setRightBarButton(favoriteBarButton, animated: false)
        
        
    
       
        
        updateUI()
        
        
    }
    
    @objc func favoriteButtonTapped(_sender: UIButton) {
        self.favoriteBarButton?.customView?.transform = CGAffineTransform(scaleX: 0, y: 0)
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            self.favorite = !self.favorite
            let image = self.favorite ? self.favoriteFullImage : self.favoriteBorderImage
            if let button = self.favoriteBarButton?.customView as? UIButton {
                button.setImage(image, for: .normal)
            }
            self.favoriteBarButton?.customView?.transform = .identity
        }, completion: nil)
    }
    
    
    func updateUI() {
        
        weatherDetail = WeatherDetail(name: weatherLocation.name, latitude: weatherLocation.latitude, longitude: weatherLocation.longitude)
        
        locationLabel.text = weatherLocation.name
        
        weatherDetail.getData {
            //self.showStandardAlert()
            DispatchQueue.main.async {
                dateFormatter.timeZone = TimeZone(identifier: self.weatherDetail.timezone)
                let usableDate = Date(timeIntervalSince1970: self.weatherDetail.currentTime)
                self.dateLabel.text = dateFormatter.string(from: usableDate)
                self.locationLabel.text = self.weatherDetail.name
                self.summaryLabel.text = self.weatherDetail.summary
                self.windBearingLabel.text = "Wind: \(self.weatherDetail.windBearing)°"
                self.windSpeedLabel.text = "Speed: \(self.weatherDetail.windSpeed)km/h"
                self.iconImage.image = UIImage(named: self.weatherDetail.icon)
                self.dailyHighLabel.text = "High:  \(self.weatherDetail.dailyWeatherData.first!.dailyHigh)°"
                self.dailyLowLabel.text = "Low:  \(self.weatherDetail.dailyWeatherData.first!.dailyLow)°"
            }
            
        }
    }
    
    private func showStandardAlert() {
        let alert = UIAlertController(title: "Warning", message: "WeatherApp has not been able to source information today", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {action in
        print("Pressed Okay")
        }))
        self.present(alert,animated: true, completion: nil)
    }


    
}
