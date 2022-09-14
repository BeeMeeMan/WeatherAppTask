//
//  UIColor+Constants.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import UIKit

extension UIColor {
    enum CustomColor {
        static let lightBlue = UIColor(named: "customLightBlue") ?? UIColor.white
        static let darkBlue = UIColor(named: "customDarkBlue") ?? UIColor.white
        static let black = UIColor(named: "customBlack") ?? UIColor.white
        static let white = UIColor(named: "customWhite") ?? UIColor.white
        static let offWhite = UIColor(named: "customOffWhite")?.withAlphaComponent(0.25)
    }
}
