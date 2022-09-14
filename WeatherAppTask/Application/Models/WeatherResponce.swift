//
//  WeatherResponce.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import Foundation

// MARK: - WeatherListResponce

struct WeatherListResponce: Codable {
    let list: [List]
    let city: City
}

// MARK: - City

struct City: Codable {
    let name: String
}

// MARK: - List

struct List: Codable {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let wind: Wind
    let visibility: Int
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, wind, visibility
        case dtTxt = "dt_txt"
    }
}

// MARK: - Main

struct MainClass: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let humidity: Int
    
    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case humidity
    }
}

// MARK: - Weather

struct Weather: Codable {
    let main: String
}

// MARK: - Wind

struct Wind: Codable {
    let speed: Double
    let deg: Int
}
