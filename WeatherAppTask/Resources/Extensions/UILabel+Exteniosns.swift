//
//  UILabel+Exteniosns.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 15.09.2022.
//

import UIKit

extension UILabel {
    static func label(withFont size: CGFloat, textColor color: UIColor = .black) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: size)
        label.textColor = color
        
        return label
    }
}
