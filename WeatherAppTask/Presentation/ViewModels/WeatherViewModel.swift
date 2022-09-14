//
//  WeatherViewModel.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import Foundation

class WeatherViewModel {
    private let weather: WeatherResponce
    
    init(weather: WeatherResponce) {
        self.weather = weather
    }
}

extension WeatherViewModel {
    var name: String {
        weather.name
    }
    
    var temp: Double {
        weather.main.temp
    }
    
    var humidity: Int {
        weather.main.humidity
    }
    
    var tempInCelsium: Double {
        return (temp - 273.15)
    }
    
    var tempInFarenheit: Double {
        return (1.8 * (temp - 273) + 32)
    }
}
