//
//  WeatherDetail.swift
//  weatherApp
//
//  Created by Troy Cavanagh on 25/4/20.
//  Copyright © 2020 Troy Cavanagh. All rights reserved.
//

import Foundation
import MessageUI

private let dateFormatter: DateFormatter = {
    print("dateformatter")
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "EEEE, MMM d"
    return dateFormatter
}()





struct DailyWeather: Codable {
    var dailyHigh: Int
    var dailyLow: Int
    var dailySummary: String
    var dailyIcon: String
    var dailyWindBearing: Int
    var dailyWindSpeed: Int
    var dailyWeekday: String
    
}

class WeatherDetail: WeatherLocation {
    
    private struct Result: Codable {
        var timezone: String!
        var currently: Currently
        var daily: Daily
    }
    private struct Currently: Codable {
        var temperature: Double
        var summary: String
        var time: TimeInterval
        var windSpeed: Double
        var windBearing: Double
        var icon: String
    }
    private struct Daily: Codable {
        var summary: String
        var icon: String
        var data: [DailyData]
    }
    
    struct DailyData: Codable {
        var icon: String
        var time: TimeInterval
        var windSpeed: Double
        var windBearing: Double
        var temperatureHigh: Double
        var temperatureLow: Double
        var summary: String
    
    }
    
    var timezone = ""
    var currentTime = 0.0
    var temperature = 0
    var summary = ""
    var icon = ""
    var dailyIcon = ""
    var windSpeed = 0.0
    var windBearing = 0.0
    var dailyWindBearing = 0.0
    var dailyWindSpeed = 0.0
    var dailyWeekDay = ""
   
    var dailyWeatherData: [DailyWeather] = []
  
    
    
    
    func getData(completed: @escaping () -> () ) {
        let coordinates = "\(latitude),\(longitude)"
        let urlString = "\(APIurls.darkSkyURL)\(APIkeys.darkSkyKey)/\(coordinates)?units=si"
        
        
        print("we are accessing URL \(urlString)")
        
        // Create a URL
        guard let url = URL(string: urlString) else {
            print("error\(urlString)")
            completed()
            return
        }
        
        // Create Session
        
        let session = URLSession.shared
        
        // Get data with .dataTask Method
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
            // deal with the data
            
            do {
                let result = try JSONDecoder().decode(Result.self, from: data!)
                self.timezone = result.timezone
                self.currentTime = result.currently.time
                self.temperature = Int(result.currently.temperature.rounded())
                self.summary = result.currently.summary
                self.windSpeed = result.currently.windSpeed
                self.windBearing = result.currently.windBearing
                self.icon = result.currently.icon
                self.dailyIcon = result.daily.icon
                    for index in 0..<result.daily.data.count{
                    let weekDayDate = Date(timeIntervalSince1970: result.daily.data[index].time)
                    dateFormatter.timeZone = TimeZone(identifier: result.timezone)
                    let dailyWeekDay = dateFormatter.string(from: weekDayDate)
                    let dailyIcon = result.daily.data[index].icon
                    let dailySummary = result.daily.data[index].summary
                    let dailyHigh = Int(result.daily.data[index].temperatureHigh.rounded())
                    let dailyLow = Int(result.daily.data[index].temperatureLow.rounded())
                    let dailyWindBearing = Int(result.daily.data[index].windBearing)
                    let dailyWindSpeed = Int(result.daily.data[index].windSpeed)
                        let dailyWeather = DailyWeather(dailyHigh: dailyHigh, dailyLow: dailyLow, dailySummary: dailySummary, dailyIcon: dailyIcon, dailyWindBearing: (dailyWindBearing), dailyWindSpeed: (dailyWindSpeed), dailyWeekday: dailyWeekDay)
                    self.dailyWeatherData.append(dailyWeather)
                    print("Day: \(dailyWeather.dailyWeekday) High: \(dailyWeather.dailyHigh) Low: \(dailyWeather.dailyLow)")
                }
                
            } catch {
                
                print(" json error: \(error.localizedDescription)")
            }
            completed()
        }
        task.resume()
        
    }
    
    //private func showStandardAlert(title: String, message: String) {
  //      let alert = UIAlertController(title: "Warning", message: "WeatherApp has not been able to source information today", preferredStyle: .alert)
  //      alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: {action in
  //         print("Pressed Okay")
  //      }))
  //      self.present(alert, animated: true, completion: nil)
 //   }
    
    
    
}


