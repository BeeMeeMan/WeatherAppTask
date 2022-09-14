//
//  WeatherType.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import Foundation

enum WeatherType: String, CaseIterable {
    case thunderstormDay = "11d"
    case rainDay = "09d10d"
    case snowDay = "13d"
    case cloudsDay = "02d03d04d50d"
    case clearDay = "01d"
    case thunderstormNight = "11n"
    case rainNight = "09n10n"
    case snowNight = "13n"
    case cloudsNight = "02n03n04n50n"
    case clearNight = "01n"
    case noData = ""
    
   private var iconName: String {
       switch self {
       case .thunderstormDay: return "ic_white_day_thunder"
       case .rainDay: return "ic_white_day_rain"
       case .snowDay: return "ic_white_day_shower"
       case .cloudsDay: return "ic_white_day_cloudy"
       case .clearDay: return "ic_white_day_bright"
       case .thunderstormNight: return "ic_white_night_thunder"
       case .rainNight: return "ic_white_night_rain"
       case .snowNight: return "ic_white_night_shower"
       case .cloudsNight: return "ic_white_night_cloudy"
       case .clearNight: return "ic_white_night_bright"
       case .noData: return ""
       }
    }
    
    var description: String {
        return String(describing: self)
    }
    
    static func getType(by iconName: String) -> Self {
        var answer: Self = .noData
        
        self.allCases.forEach { weatherType in
            if weatherType.rawValue.contains(iconName) {
                answer = weatherType
            }
        }
        
        return answer
    }
}
