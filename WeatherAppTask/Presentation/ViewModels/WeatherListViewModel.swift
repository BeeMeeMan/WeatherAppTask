//
//  WeatherListViewModel.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import Foundation
import CoreLocation

class WeatherListViewModel {
    private var networkService: NetworkService
    private var weatherList: [WeatherViewModel] = []
    private var location: CLLocation?
    private var city = ""
    
    var handleSwitchToMap: () -> Void = {}
    var handleSwitchToCityPick: () -> Void = {}
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
}

extension WeatherListViewModel {
    var cityName: String {
        city
    }
    
    var list: [WeatherViewModel] {
        return weatherList
    }
    
    var isNoData: Bool {
        return weatherList.count == 0
    }
    
    func setLocation(_ location: CLLocation?) {
        self.location = location
    }
    
    func getWeather(completion: @escaping(Bool) -> Void) {
        guard let location = location else {
            completion(false)
            return
        }
        
        networkService.getWeather(by: location) { responce in
            if let responce = responce {
                self.weatherList = responce.list.map(WeatherViewModel.init)
                self.city = responce.city.name
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
            return getDayWeatherFromThreeHourInterval()[index]
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
