//
//  WeatherDataModel.swift
//  Wetter App Test
//
//  Created by Dirk Meyer on 01.12.23.
//

import Foundation

// struct Structs Werttypen, während Klassen Referenztypen sind. Wenn Sie eine Struktur kopieren, erhalten Sie zwei eindeutige Kopien der Daten.
// Decodable --> Protocol zum umwandeln der JSON

struct WeatherData: Decodable {
    let name: String
    let main: Main
    let wind: Wind
    let sys: Sys
    let clouds: Clouds
    let weather: [Weather] //da in der JSON ein Array muss der Datentyp so angegeben werden
    
}

//Bezieht sich auf die Datentyp "MAIN" in WeatherData
struct Main: Decodable {
    let temp: Double
    let temp_min: Double
    let temp_max: Double
    let pressure: Int
    let humidity: Int
}

struct Wind: Decodable{
    let speed: Double
}

struct Sys: Decodable{
    let sunrise: Double
    let sunset: Double
}

struct Clouds: Decodable{
    let all: Double
}


struct Weather: Decodable{
    let id: Int
    let description: String
}
