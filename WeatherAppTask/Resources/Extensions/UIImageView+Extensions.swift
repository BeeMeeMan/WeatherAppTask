//
//  UIImageView+Extensions.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 15.09.2022.
//

import UIKit

extension UIImageView {
    static func imageView(height: CGFloat, width: CGFloat) -> UIImageView {
        let image = UIImageView()
        image.setDimensions(height: height, width: width)
        
        return image
    }
    
    static func imageView(size: CGSize) -> UIImageView {
        let image = UIImageView()
        image.setDimensions(height: size.height, width: size.width)
        
        return image
    }
}
