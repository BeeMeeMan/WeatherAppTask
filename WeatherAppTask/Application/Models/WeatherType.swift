//
//  WeatherType.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import Foundation

enum WeatherType: String, CustomStringConvertible {
    case clearSky
    case fewClouds
    case scatteredClouds
    case brokenClouds
    case showerRain
    case rain
    case thunderstorm
    case snow
    case mist
    case noInfo
    
    var iconName: String {
        switch self {
        case .clearSky: return "sun.max"
        case .fewClouds: return "cloud.sun"
        case .scatteredClouds: return "cloud"
        case .brokenClouds: return "cloud.fill"
        case .showerRain: return "cloud.rain"
        case .rain: return "cloud.sun.rain"
        case .thunderstorm: return "cloud.bolt"
        case .snow: return "cloud.snow"
        case .mist: return "cloud.fog"
        case .noInfo: return "questionmark.circle"
        }
    }
    
    var description: String {
        return self.rawValue.addSpacesRemoveUppercase()
    }
    
    static func getType(by description: String) -> Self {
        return Self.init(rawValue: description.removeSpacesAddUppercase()) ?? .noInfo
    }
}

fileprivate extension String {
    func addSpacesRemoveUppercase() -> Self {
        var result = ""
        self.forEach { char in
            if char.isUppercase {
                result.append(contentsOf: " \(char.lowercased())")
            } else {
                result.append(char)
            }
        }
        
        return result
    }
    
    func removeSpacesAddUppercase() -> Self {
        var result = ""
        var wasSpace = false
        
        self.forEach { char in
            if char.isWhitespace {
                wasSpace = true
            } else if wasSpace {
                result.append(char.uppercased())
            } else {
                result.append(char)
            }
        }
        
        return result
    }
}
