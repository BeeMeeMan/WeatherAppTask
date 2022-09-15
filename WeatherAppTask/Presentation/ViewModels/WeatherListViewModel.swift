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
    private var city = "Kiev"
    
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

    var isNoData: Bool {
        return weatherList.count == 0
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
    
    func getWeatherViewModel(at index: Int) -> WeatherViewModel {
        if isNoData {
            return WeatherViewModel(weather: nil)
        } else {
            return weatherList[index]
        }
    }
    
    func numberOfRowsInSectionFromThreeHourInterval(section: Int) -> Int {
        return getDayWeatherFromThreeHourInterval().count
    }
    
    func getWeatherViewModelFromThreeHourInterval(at index: Int) -> WeatherViewModel {
        if isNoData {
            return WeatherViewModel(weather: nil)
        } else {
            return getDayWeatherFromThreeHourInterval()[index]
        }
    }
    
    private func getDayWeatherFromThreeHourInterval() ->  [WeatherViewModel] {
        var index = 1
        var answer = [WeatherViewModel]()
        
        for item in weatherList {
            if index % 8 == 0 || index == 1 {
                answer.append(item)
            }
            index += 1
        }
        
        return answer
    }
}
