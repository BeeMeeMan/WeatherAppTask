//
//  UIScreen+Extensions.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 15.09.2022.
//

import UIKit

enum DeviceOrientation {
    case portrait
    case landscape
}

extension UIScreen {
    static let width = UIScreen.main.bounds.size.width
    static let height = UIScreen.main.bounds.size.height
    
    
    static func getOrientation(by traitCollection: UITraitCollection) -> DeviceOrientation {
        if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
            return .portrait
        }
        return .landscape
    }
    
    static func getOrientation() -> DeviceOrientation {
        if UIScreen.height > UIScreen.width {
            return .portrait
        } else {
            return .landscape
        }
    }
}

