//
//  weeklyForecastViewController.swift
//  weatherApp
//
//  Created by Troy Cavanagh on 2/5/20.
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

class WeeklyForecastViewController: UIViewController {
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dailyTableView: UITableView!
    
     @objc var favourite: String!
    var dailyWeatherData: [DailyWeather] = []
    var weatherDetail: WeatherDetail!
    var weatherLocation: WeatherLocation!
    var weatherLocations: [WeatherLocation] = []
    
    var favoriteBarButton: UIBarButtonItem?
    var favorite: Bool = false
    let favoriteBorderImage = UIImage(named: "baseline_favorite_border_black_48pt")?.withRenderingMode(.alwaysTemplate)
    let favoriteFullImage = UIImage(named: "baseline_favorite_black_48pt")?.withRenderingMode(.alwaysTemplate)

    var forecast: Forecast!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        
        dailyTableView.delegate = self
        dailyTableView.dataSource = self
        
        let favoriteButton = UIButton(type: .system)
        favoriteButton.tintColor = .red
        favoriteButton.setImage(self.favoriteBorderImage, for: .normal)
        favoriteButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        self.favoriteBarButton = UIBarButtonItem(customView: favoriteButton)
        self.navigationItem.setRightBarButton(favoriteBarButton, animated: false)
        
        
        
        if weatherLocation == nil {
            weatherLocation = WeatherLocation(name: "??", latitude: -37.9995, longitude: 145.0940)
            weatherLocations.append(weatherLocation)
        }
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
              // let usableDate = Date(timeIntervalSince1970: self.weatherDetail.currentTime)
              // self.dateLabel.text = dateFormatter.string(from: usableDate)
              self.dailyTableView.reloadData()
           }
       }
    }
}
extension WeeklyForecastViewController: UITableViewDataSource, UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDetail.dailyWeatherData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weeklyCell", for: indexPath) as! DailyTableViewCell
        cell.dailyWeather = weatherDetail.dailyWeatherData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 190
    }
    
    private func showStandardAlert() {
        let alert = UIAlertController(title: "Warning", message: "WeatherApp has not been able to source information today", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {action in
            print("Pressed Okay")
        }))
        self.present(alert,animated: true, completion: nil)
    }
    
    }
    

