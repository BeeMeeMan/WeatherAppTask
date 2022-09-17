//
//  NSLayoutConstraint+Extensions.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 17.09.2022.
//

import UIKit

class SizeClass {
    var portraitConstraints: [NSLayoutConstraint] = []
    var landscapeConstraints: [NSLayoutConstraint] = []
    
    init(portrait: [NSLayoutConstraint], landscape: [NSLayoutConstraint]) {
        self.portraitConstraints = portrait
        self.landscapeConstraints = landscape
    }

    func setup(with deviceOrientation: DeviceOrientation, portraitCompletion: @escaping()->(), landscapeCompletion: @escaping()->()) {
        switch deviceOrientation {
        case .portrait:
            setConstraints(portraitConstraints, to: true)
            setConstraints(landscapeConstraints, to: false)
            portraitCompletion()
        case .landscape:
            setConstraints(portraitConstraints, to: false)
            setConstraints(landscapeConstraints, to: true)
            landscapeCompletion()
        }
    }
    
   private func setConstraints(_ constraints: [NSLayoutConstraint], to value: Bool) {
        constraints.forEach { element in
            element.isActive = value
        }
    }
}
