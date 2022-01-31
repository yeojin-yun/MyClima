//
//  WeatherData.swift
//  Myclimate
//
//  Created by 순진이 on 2022/01/30.
//

import Foundation

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let weather: [Weather]
    
    struct Main: Decodable {
        let temp: Double
    }
    
    struct Weather: Decodable {
        let id: Int
    }
}

