//
//  WeatherResponce.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import Foundation

// MARK: - Welcome

struct WeatherResponce: Codable {
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
    let weather: [Weather]
    let wind: Wind
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, weather, wind
        case dtTxt = "dt_txt"
    }
}

// MARK: - Main

struct Main: Codable {
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
    let icon: String
}

// MARK: - Wind

struct Wind: Codable {
    let speed: Double
    let deg: Int
}
