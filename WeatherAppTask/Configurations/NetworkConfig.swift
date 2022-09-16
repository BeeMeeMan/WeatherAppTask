//
//  NetworkConfig.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import Foundation
import MapKit
//https://api.openweathermap.org/data/2.5/forecast?q=Kharkiv&appid=935816ca51975865a24c12784fe691a1
//https:api.openweathermap.org/data/2.5/forecast?q=Kharkiv&appid=935816ca51975865a24c12784fe691a1
//https:api.openweathermap.org/data/2.5/forecast?lat=50.42929&lon=30.53806&appid=935816ca51975865a24c12784fe691a1

enum NetworkConfig {
    private enum APIKeys {
        static let weatherAPIKey = "935816ca51975865a24c12784fe691a1"
    }
    
    enum Urls {
        static func urlForWeatherList(by location: CLLocation) -> URL? {
            let lat = String(location.coordinate.latitude)
            let lon = String(location.coordinate.longitude)
            return  URL(string: "https:api.openweathermap.org/data/2.5/forecast?lat=\(lat)&lon=\(lon)&appid=\(APIKeys.weatherAPIKey)")
        }
        static func urlForWeatherList(by city: String) -> URL? {
            return  URL(string: "https:api.openweathermap.org/data/2.5/forecast?q=\(city.escaped())&appid=\(APIKeys.weatherAPIKey)")
        }
    }
}
