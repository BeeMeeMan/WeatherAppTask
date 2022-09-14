//
//  WeatherViewModel.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import Foundation

typealias TemperatureDegrees = Double

class WeatherViewModel {
    private let weather: WeatherResponce
    
    init(weather: WeatherResponce) {
        self.weather = weather
    }
}

//extension WeatherViewModel {
//    var name: String {
//        weather.list.
//    }
//    
//    var temp: TemperatureDegrees {
//        weather.main.temp
//    }
//    
//    var tempMin: TemperatureDegrees {
//        weather.main.tempMin
//    }
//    
//    var tempMax: TemperatureDegrees {
//        weather.main.tempMax
//    }
//    
//    var humidity: Int {
//        weather.main.humidity
//    }
//    
//    var windSpeed: Double {
//        weather.wind.speed
//    }
//    
//    var windDegree: Int {
//        weather.wind.deg
//    }
//    
//    var windDirection: WindDirection {
//        WindDirection.getType(by: windDegree)
//    }
//    
//    var weatherType: WeatherType {
//        WeatherType.getType(by: weather.weather.first?.main ?? "")
//    }
//}
//
//// MARK: - TemperatureDegrees
//
//extension TemperatureDegrees {
//    func tempInCelsium() -> Self {
//        return (self - 273.15)
//    }
//    
//    func tempInFarenheit() -> Self {
//        return (1.8 * (self - 273) + 32)
//    }
//}
