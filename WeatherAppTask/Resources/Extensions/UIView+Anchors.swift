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
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = .zero,
                paddingBottom: CGFloat = .zero,
                paddingLeft: CGFloat = .zero,
                paddingRight: CGFloat = .zero,
                width: CGFloat? = nil,
                height: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func center(by: AxisType, inView view: UIView,
                leftAnchor: NSLayoutXAxisAnchor? = nil,
                paddingLeft: CGFloat = 0,
                constant: CGFloat = 0,
                constantAllX: CGFloat = 0,
                constantAllY: CGFloat = 0) {
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
        
        if let leftAnchor = leftAnchor {
            anchor(left: leftAnchor, paddingLeft: paddingLeft)
        }
    }
    
    func pinTo(view: UIView, padding: CGFloat = .zero) {
        anchor(top: view.topAnchor,
               bottom: view.bottomAnchor,
               left: view.leftAnchor,
               right: view.rightAnchor,
               paddingTop: padding,
               paddingBottom: padding,
               paddingLeft: padding,
               paddingRight: padding)
    }
    
    func setDimensions(height: CGFloat, width: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
        widthAnchor.constraint(equalToConstant: width).isActive = true
    }
    
    func setHeight(_ height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius

        layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }
}
