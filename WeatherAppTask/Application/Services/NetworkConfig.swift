//
//  NetworkConfig.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import Foundation
//https://api.openweathermap.org/data/2.5/forecast?q=Kharkiv&appid=935816ca51975865a24c12784fe691a1
//api.openweathermap.org/data/2.5/forecast/daily?q={city name}&cnt={cnt}&appid={API key}
enum NetworkConfig {
    private enum APIKeys {
        static let weatherAPIKey = "935816ca51975865a24c12784fe691a1"
    }
    
    enum Urls {
        static func urlForWeather(by city: String) -> URL? {
            return  URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(city.escaped())&appid=\(APIKeys.weatherAPIKey)")
        }
        static func urlForWeather(by city: String, and daysCount: Int) -> URL? {
            return  URL(string: "https://api.openweathermap.org/data/2.5/forecast/daily?q=\(city.escaped())&cnt=\(daysCount)&appid=\(APIKeys.weatherAPIKey)")
        }
    }
}
