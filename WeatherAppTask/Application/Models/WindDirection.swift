//
//  WindDirections.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import Foundation

enum WindDirection: Int, CaseIterable {
    case north = 0
    case northeast = 45
    case east = 90
    case southeast = 135
    case south = 180
    case southwest = 225
    case west = 270
    case northwest = 315
    case noWind = 999
    
    var iconName: String {
        switch self {
        case .north: return "arrow.up"
        case .northeast: return "arrow.up.right"
        case .east: return "arrow.right"
        case .southeast: return "arrow.down"
        case .south: return "arrow.down"
        case .southwest: return "arrow.down.left"
        case .west: return "arrow.left"
        case .northwest: return "arrow.up.left"
        case .noWind: return ""
        }
    }

    static func getType(by degrees: Int) -> Self {
        if degrees > 360 { return .noWind }
        if degrees > 338 { return .north}
        
        let allPosition = self.allCases.map{ $0.rawValue }
        var closest = 0
        
        for item in allPosition {
            if abs(degrees - item) < abs(degrees - closest) {
                closest = item
            }
        }
    
        return Self.init(rawValue: closest) ?? .noWind
    }
}
