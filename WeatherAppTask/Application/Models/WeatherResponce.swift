//
//  WeatherResponce.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import Foundation

// MARK: - Welcome

struct WeatherResponce: Codable {
    let name: String
    let main: Main
    let wind: Wind
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

// MARK: - Wind

struct Wind: Codable {
    let speed: Double
    let deg: Int
}
