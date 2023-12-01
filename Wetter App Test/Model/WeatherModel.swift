//
//  WeatherModel.swift
//  Wetter App Test
//
//  Created by Dirk Meyer on 01.12.23.
//

import Foundation

struct WeatherModel {
    // Stored property -> Wert wird einfach nur dort gelagert / gespeichert
        let conditionId: Int
        let cityName: String
        let temperature: Double
        let description: String
        
        // Zusatzinfos
        let sunrise: Double
        let sunset: Double
        let temp_max: Double
        let temp_min: Double
        let pressure: Int
        let humidity: Int
        let rain: Double
        let windSpeed: Double
        
        // computed Property -> Wert wird jedesmal errechnet
        var temperatureASString: String {
            return String(format: "%.1f", temperature)
        }
        
        var conditionName: String {
            switch conditionId {
            case 200...232:
                return "cloud.bolt"
            case 300...321:
                return "cloud.drizzle"
            case 500...531:
                return "cloud.rain"
            case 600...622:
                return "cloud.snow"
            case 701...781:
                return "cloud.fog"
            case 800:
                return "sun.max"
            case 801...804:
                return "cloud.bolt"
            default:
                return "cloud"
            }
        }
        
    }
