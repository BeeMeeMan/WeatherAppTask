//
//  WeatherViewModel.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import Foundation

class WeatherViewModel {
    private let weather: List?
    private let noData: String = "n/a "
    
    init(weather: List?) {
        self.weather = weather
    }
}

extension WeatherViewModel {
    var temp: String {
        guard let weather = weather else { return noData + "°" }
        return Int(weather.main.temp.inCelsium()).asString()
    }
    
    var tempMin: String {
        guard let weather = weather else { return noData + "°" }
        return Int(weather.main.tempMin.inCelsium()).asString()
    }
    
    var tempMax: String {
        guard let weather = weather else { return noData + "°" }
        return Int(weather.main.tempMax.inCelsium()).asString()
    }
    
    var humidity: String {
        guard let weather = weather else { return noData + "%" }
        return String("\(weather.main.humidity)%")
    }
    
    var windSpeed: String {
        guard let weather = weather else { return noData + "м/cек" }
        return String("\(weather.wind.speed.rounded()) м/cек")
    }
    
    var windDegree: Int {
        guard let weather = weather else { return 500 }
        return weather.wind.deg
    }
    
    var windDirection: WindDirection {
        WindDirection.getType(by: windDegree)
    }
    
    var weatherType: WeatherType {
        guard let weather = weather else { return .noData }
        return WeatherType.getType(by: weather.weather.first?.icon ?? "")
    }
    
    var date: String {
        guard let weather = weather else { return noData }
        return weather.dt.getDateWithFormat("E, d MMMM")
    }
    
    var dayOfWeek: String {
        guard let weather = weather else { return noData }
        return weather.dt.getDateWithFormat("E")
    }
    
    var time: String {
        guard let weather = weather else { return noData }
        return weather.dt.getDateWithFormat("HH:mm")
    }
}

fileprivate extension Double {
    func inCelsium() -> Self {
        return (self - 273.15)
    }
    
    func inFarenheit() -> Self {
        return (1.8 * (self - 273) + 32)
    }
}

fileprivate extension Int {
    func asString() -> String {
        String("\(self)°")
    }
    
    func getDateWithFormat(_ format: String) -> String {
            let utcDateFormatter = DateFormatter()
            utcDateFormatter.dateFormat = format
            
            let date = Date(timeIntervalSince1970: TimeInterval(self))

            return utcDateFormatter.string(from: date)
    }
}
