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
}
