//
//  WeatherListViewModel.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import Foundation

class WeatherListViewModel {
    private var networkService: NetworkService
    private var weatherList: [WeatherViewModel] = []
    private var city = "" 
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func setCity(_ name: String) {
        city = name
    }
}

extension WeatherListViewModel {
    var cityName: String {
        city
    }

    var dayWeatherList: [WeatherViewModel] {
        return getDayWeatherFromThreeHourInterval(weatherArray: weatherList)
    }
    
    func getWeather(completion: @escaping(Bool) -> Void) {
        networkService.getWeather(for: city) { responce in
            if let responce = responce {
                self.weatherList = responce.list.map(WeatherViewModel.init)
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return weatherList.count
    }
    
    func getWeatherViewModel(at index: Int) -> WeatherViewModel? {
        if weatherList.count >= index + 1 {
            return weatherList[index]
        } else {
            return nil
        }
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
