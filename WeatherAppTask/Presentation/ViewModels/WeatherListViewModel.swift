//
//  WeatherListViewModel.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import Foundation

class WeatherListViewModel {
    private var weatherList: [WeatherViewModel]
    private var city = ""
    
    init(weatherListResponce: WeatherListResponce) {
        self.weatherList = weatherListResponce.list.map(WeatherViewModel.init)
        self.city = weatherListResponce.city.name
    }
    
    var cityName: String {
        city
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return weatherList.count
    }
    
    func getWeatherViewModel(at index: Int) -> WeatherViewModel {
        return weatherList[index]
    }
    
    func switchWeather(to viewModelList: [WeatherViewModel]) {
        weatherList = viewModelList
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
