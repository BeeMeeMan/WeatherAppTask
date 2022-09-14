//
//  WeatherListViewModel.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import Foundation

class WeatherListViewModel {
    private let weatherList: [WeatherViewModel]
    
    init(weatherList: [List]) {
        self.weatherList = weatherList.map(WeatherViewModel.init)
    }
    
    var dayWeatherList: [WeatherViewModel] {
        return getDayWeatherFromThreeHourInterval(weatherArray: weatherList)
    }
    
    private func getDayWeatherFromThreeHourInterval(weatherArray: [WeatherViewModel]) ->  [WeatherViewModel] {
        var index = 1
        var answer = [WeatherViewModel]()
        
        for item in weatherArray {
          if index % 8 == 0 || index == 1 {
              answer.append(item)
          }
          index += 1
        }
        
        return answer
    }
}
