//
//  TemperatureDegrees+Extensions.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import Foundation

extension TemperatureDegrees {
    func tempInCelsium() -> Self {
        return (self - 273.15)
    }

    func tempInFarenheit() -> Self {
        return (1.8 * (self - 273) + 32)
    }
    
    func asString() -> String {
        String("\(self)°")
    }
}
