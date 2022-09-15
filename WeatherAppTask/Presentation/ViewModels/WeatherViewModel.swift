//
//  WeatherViewModel.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import Foundation

class WeatherViewModel {
    private let weather: List

    init(weather: List) {
        self.weather = weather
    }
}

extension WeatherViewModel {
    var temp: String {
        weather.main.temp.inCelsium().asString()
    }

    var tempMin: String {
        weather.main.tempMin.inCelsium().asString()
    }

    var tempMax: String {
        weather.main.tempMax.inCelsium().asString()
    }

    var humidity: String {
        String("\(weather.main.humidity)%")
    }

    var windSpeed: String {
        String("\(weather.wind.speed) м/cек")
    }
    
    var windDegree: Int {
        weather.wind.deg
    }

    var windDirection: WindDirection {
        WindDirection.getType(by: windDegree)
    }

    var weatherType: WeatherType {
        WeatherType.getType(by: weather.weather.first?.icon ?? "")
    }
    
    var date: String {
        let utcDateFormatter = DateFormatter()
        utcDateFormatter.dateStyle = .medium

        utcDateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let date = Date()
        print(utcDateFormatter.string(from: date))
        return weather.dt.toDate()
    }
}

fileprivate extension Double {
    func inCelsium() -> Self {
        return (self - 273.15)
    }

    func inFarenheit() -> Self {
        return (1.8 * (self - 273) + 32)
    }
    
    func asString() -> String {
        String("\(self)°")
    }
}
