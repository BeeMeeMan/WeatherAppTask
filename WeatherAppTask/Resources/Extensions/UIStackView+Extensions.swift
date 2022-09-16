//
//  UIStack+Extensions.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 16.09.2022.
//

import UIKit

extension UIStackView {
    static func hStack(subviews: [UIView] = [], spacing: CGFloat = 0, distribution: UIStackView.Distribution = .fill) -> Self {
        let stack = Self(arrangedSubviews: subviews)
        stack.axis = .horizontal
        stack.distribution = distribution
        stack.spacing = spacing
        
        return stack
    }
    
    static func vStack(subviews: [UIView] = [], spacing: CGFloat = 0, distribution: UIStackView.Distribution = .fill) -> Self {
        let stack = Self(arrangedSubviews: subviews)
        stack.axis = .vertical
        stack.distribution = distribution
        stack.spacing = spacing
        
        return stack
    }
}
