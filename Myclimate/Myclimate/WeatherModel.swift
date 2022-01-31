//
//  WeatherModel.swift
//  Myclimate
//
//  Created by 순진이 on 2022/01/30.
//

import Foundation

struct WeatherModel {
    let cityName: String
    let temperature: Double
    let conditionId: Int
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String {
        switch conditionId {
        case 200...299:
            return "cloud.bolt"
        case 300...399:
            return "cloud.drizzle"
        case 500...599:
            return "cloud.rain"
        case 600...699:
            return "cloud.snow"
        case 700...799:
            return "cloud.fog"
        case 800:
            return "sun.max.fill"
        case 801...804:
            return "cloud"
        default:
            return "cloud.fill"
        }
    }
}
