//
//  WeatherViewModel.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import Foundation

typealias TemperatureDegrees = Double

class WeatherViewModel {
    private let weather: List

    init(weather: List) {
        self.weather = weather
    }
}

extension WeatherViewModel {
    var temp: TemperatureDegrees {
        weather.main.temp
    }

    var tempMin: TemperatureDegrees {
        weather.main.tempMin
    }

    var tempMax: TemperatureDegrees {
        weather.main.tempMax
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
        utcDateFormatter.timeStyle = .medium

        // The default timeZone on DateFormatter is the device’s
        // local time zone. Set timeZone to UTC to get UTC time.
        utcDateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        // Printing a Date
        let date = Date()
        print(utcDateFormatter.string(from: date))
        return weather.dt.toDate()
    }
}
