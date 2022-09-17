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
    
    static func getOrientation1() -> DeviceOrientation {
        if  UIDevice.current.orientation.isPortrait {
            return .portrait
        } else {
            return .landscape
        }
    }
}
