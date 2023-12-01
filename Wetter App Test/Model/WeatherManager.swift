//
//  WeatherManager.swift
//  Wetter App Test
//
//  Created by Dirk Meyer on 29.11.23.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    
    let UNIT = "Metric"
    let LANGUAGE = "de"
    let ID = "74ecd2f42c4eb136a60fcc0021e20134"
    let WEATHER_URL_BY_CITYNAME = "https://api.openweathermap.org/data/2.5/weather?q="
    
    var delegate: WeatherManagerDelegate? // -> Hier drin ist der WeatherViewController
    
    func fetchWeather(cityName: String) {
        // URL zur API bauen
        let urlAsString = WEATHER_URL_BY_CITYNAME + cityName + "&appid=\(ID)" + "&units=\(UNIT)" + "&lang=\(LANGUAGE)"
        print(urlAsString)
        performRequest(urlString: urlAsString)
    }
    
    func performRequest(urlString: String) {
        // 1. URL erstellen
        guard let url = URL(string: urlString) else { return }
        // 2. URL Session erstellen (Sitzung erstellen)
        let session = URLSession(configuration: .default)
        // 3. Die Task erstellen
        let task = session.dataTask(with: url) { (data, urlRepsonse, error) in
            if error != nil {
                print(error!)// "!" bedeutet Unwrapping wird entpackt
                return
            }
            
            // Ansonsten haben wir Daten
            if let _data = data { // _data -> JSON
                if let weather = parseJSON(_data) {
                    // weather Objekt zum WeatherViewController verschicken
                    self.delegate?.didUpdateWeather(weather: weather)
                }
            }
        }
        // 4. Task starten
        task.resume()
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
      let decoder = JSONDecoder()
        
        // "name": "Berlin" -> In Swift decoden
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
           
            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let description = decodeData.weather[0].description
            let name = decodeData.name
            
            // Zusatzinfos decodieren aus dem JSON Format
            let sunrise = decodeData.sys.sunrise
            let sunset = decodeData.sys.sunset
            let temp_max = decodeData.main.temp_max
            let temp_min = decodeData.main.temp_min
            let pressure = decodeData.main.pressure
            let humidity = decodeData.main.humidity
            let rain = decodeData.clouds.all
            let windSpeed = decodeData.wind.speed
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, description: description, sunrise: sunrise, sunset: sunset, temp_max: temp_max, temp_min: temp_min, pressure: pressure, humidity: humidity, rain: rain, windSpeed: windSpeed)
            
            return weather
            
        } catch {
            print(error)
            return nil
        }
    }
}
