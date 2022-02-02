//
//  ViewController.swift
//  Myclimate
//
//  Created by 순진이 on 2022/01/29.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var climateImg: UIImageView!
    @IBOutlet weak var locationButton: UIButton!
    
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    
    let weatherTitle = "🌈How is the weather?"
    let emptyText = ""
    var charIndex = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        
        
        // Location Manager
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        
        // Typing Animation
        titleLabel.text = ""
        for char in weatherTitle {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { timer in
                self.titleLabel.text?.append(char)
            }
            charIndex += 1
        }
    }

    @IBAction func searchBtnTapped(_ sender: UIButton) {
        textField.endEditing(true)
        print(textField.text!)
        if let city = textField.text {
            weatherManager.fetchWeather(cityName: city)
        }
        
    }

    @IBAction func locationTapped(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitute: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

extension ViewController: WeatherManagerDelegate {
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.climateImg.image = UIImage(systemName: weather.conditionName)
            self.cityNameLabel.text = weather.cityName
        }
    }
}

//MARK: -UITextField
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "도시를 검색하세요 ⌨️"
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = textField.text {
            weatherManager.fetchWeather(cityName: city)
        }
    }
}


