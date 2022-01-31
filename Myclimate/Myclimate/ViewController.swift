//
//  ViewController.swift
//  Myclimate
//
//  Created by 순진이 on 2022/01/29.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var climateImg: UIImageView!
    @IBOutlet weak var locationButton: UIButton!
    
    var weatherManager = WeatherManager()
    
    let weatherTitle = "🌈How is the weather?"
    let emptyText = ""
    var charIndex = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        weatherManager.delegate = self
        
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
    
}

extension ViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weatherModel: WeatherModel) {
        print(weatherModel.temperatureString)
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
            cityNameLabel.text = city
        }
    }
}


