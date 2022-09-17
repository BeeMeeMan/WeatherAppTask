//
//  UIView+Anchors.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import UIKit

extension UIView {
    enum AxisType {
        case xAxis
        case yAxis
        case allAxis
    }
    
    func pin(top: NSLayoutYAxisAnchor, padding: CGFloat = .zero) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: top, constant: padding).isActive = true
        return self
    }
    
    func pin(bottom: NSLayoutYAxisAnchor, padding: CGFloat = .zero) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        bottomAnchor.constraint(equalTo: bottom, constant: -padding).isActive = true
        return self
    }
    
    func pin(left: NSLayoutXAxisAnchor, padding: CGFloat = .zero) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: left, constant: padding).isActive = true
        return self
    }
    
    func pin(right: NSLayoutXAxisAnchor, padding: CGFloat = .zero) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        rightAnchor.constraint(equalTo: right, constant: -padding).isActive = true
        return self
    }
    
    func pinDimentions(height: CGFloat? = nil , width: CGFloat? = nil) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        return self
    }
    
    func center(by: AxisType, inView view: UIView,
                  constant: CGFloat = 0,
                  constantAllX: CGFloat = 0,
                  constantAllY: CGFloat = 0) -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        
        switch by {
        case .xAxis:
            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constant).isActive = true
        case .yAxis:
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        case .allAxis:
            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: constantAllX).isActive = true
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constantAllY).isActive = true
        }
        
        return self
    }
    
    func pinAll(view: UIView, padding: CGFloat = .zero) {
        self
            .pin(top: view.topAnchor, padding: padding)
            .pin(left: view.leftAnchor, padding: padding)
            .pin(right: view.rightAnchor, padding: padding)
            .pin(bottom: view.bottomAnchor, padding: padding)
            .closeEdit()
    }
    
    func closeEdit() { }
}
