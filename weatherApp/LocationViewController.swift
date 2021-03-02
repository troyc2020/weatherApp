//
//  ViewController.swift
//  weatherApp
//
//  Created by Troy Cavanagh on 24/4/20.
//  Copyright © 2020 Troy Cavanagh. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addBarButton: UIBarButtonItem!
    @IBOutlet weak var editBarButton: UIToolbar!
    
    var weatherDetail: WeatherDetail!
    var weatherLocation: WeatherLocation!
    
    
    var weatherLocations: [WeatherLocation] = [WeatherLocation(name: "Mordialloc", latitude: -37.9995, longitude: 145.0940),
                                               WeatherLocation(name: "Singapore", latitude: 1.3521, longitude: 103.8198),
                                               WeatherLocation(name: "London", latitude: 51.5074, longitude: -0.1278),
                                               WeatherLocation(name: "Paris", latitude: 48.8566, longitude: 2.3522),
                                               WeatherLocation(name: "New York", latitude: 40.7128, longitude: -74.0060),
                                               WeatherLocation(name: "Moscow", latitude: 55.7558, longitude: 37.6173),
                                               WeatherLocation(name: "Cape Town", latitude: -33.92949, longitude: 18.4241),
                                               WeatherLocation(name: "Johannesburg", latitude: -26.2041, longitude: 28.0473),
                                               WeatherLocation(name: "Sydney", latitude: -33.8688, longitude: 151.2093),
                                               WeatherLocation(name: "Melbourne", latitude: -37.8136, longitude: 144.9631),
                                               WeatherLocation(name: "Brisbane", latitude: -27.4968, longitude: 153.0251),
                                               WeatherLocation(name: "Nadi", latitude: -17.7765, longitude: 177.4365),
                                               WeatherLocation(name: "Auckland", latitude: -36.8485, longitude: 174.7633),
                                               WeatherLocation(name: "Tokyo", latitude: 35.67262, longitude: 139.6503),
                                               WeatherLocation(name: "Beijing", latitude: 39.9042, longitude: 116.4074),
                                               WeatherLocation(name: "Osaka", latitude: 34.6413, longitude: 135.5629),
                                               WeatherLocation(name: "Ho Chi Minh", latitude: 10.8231, longitude: 106.6297),
                                               WeatherLocation(name: "Hanoi", latitude: 21.0278, longitude: 105.8342),
                                               WeatherLocation(name: "Los Angeles", latitude: 34.0522, longitude: -118.2437),
                                               WeatherLocation(name: "San Francisco", latitude: 37.7749, longitude: -122.4194)]
            
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
    
    if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            sender.title = "Edit"
            addBarButton.isEnabled = true
        } else {
            tableView.setEditing(true, animated: true)
            sender.title = "Done"
            addBarButton.isEnabled = false
            
        }
        }
    }


extension LocationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherLocations.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = weatherLocations[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            weatherLocations.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemToMove = weatherLocations[sourceIndexPath.row]
        weatherLocations.remove(at: sourceIndexPath.row)
        weatherLocations.insert(itemToMove, at: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "locationSeque" {
            let destination = segue.destination as! ForecastSelectViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.weatherLocation = weatherLocations[selectedIndexPath.row]
       
        

}
}
}
