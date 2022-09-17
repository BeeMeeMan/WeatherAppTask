//
//  NSLayoutConstraint+Extensions.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 17.09.2022.
//

import UIKit

extension Array where Element: NSLayoutConstraint {
    func activate() {
        self.forEach { element in
            element.isActive = true
        }
    }
    
    func deactivate() {
        self.forEach { element in
            element.isActive = false
        }
    }
}
