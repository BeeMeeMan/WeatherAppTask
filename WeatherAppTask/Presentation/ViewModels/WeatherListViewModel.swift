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
}
