//
//  UIButton+Extensions.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 16.09.2022.
//

import UIKit

extension UIButton {
    static func button(_ title: String = "") -> Self {
        let button = Self(type: .system)
        button.setTitle(title, for: .normal)
        
        return button
    }
    
    func lzSetImage(_ image: UIImage?) -> Self {
        self.setImage(image, for: .normal)
        return self
    }
    
    func lzAddTarget(_ target: Any?, selector: Selector) -> Self {
        self.addTarget(target, action: selector, for: .touchUpInside)
        return self
    }
    
    func lzSetTitle(_ title: String? = nil, color: UIColor? = nil, font: UIFont? = nil) -> Self {
        if let title = title {
            self.setTitle(title, for: .normal)
        }
        
        if let color = color {
            self.setTitleColor(color, for: .normal)
        }
       
        if let font = font {
            self.titleLabel?.font = font
        }
        
        return self
    }
}
