//
//  InfoContainer.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import UIKit

enum InfoContainerType {
    case temperature
    case humidity
    case wind
    
    var iconName: String {
        switch self {
        case .temperature: return "ic_temp"
        case .humidity: return "ic_humidity"
        case .wind: return "ic_wind"
        }
    }
}

class InputContainerView: UIView {
    
    // MARK: - Properties
    
    private let weatherVM: WeatherViewModel
    private let infoContainerType: InfoContainerType
    
    private lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: infoContainerType.iconName)
        image.tintColor = .CustomColor.white
        image.setDimensions(height: 24, width: 24)
        
        return image
    }()
    
    private lazy var windImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: weatherVM.windDirection.iconName)
        image.tintColor = .CustomColor.white
        image.setDimensions(height: 24, width: 24)
        
        return image
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .CustomColor.white
        label.textAlignment = .left
        label.text = getLabelText()
        
        return label
    }()
    
    // MARK: - Lifecycle
    
    init(weatherVM: WeatherViewModel, containerType: InfoContainerType) {
        self.weatherVM = weatherVM
        self.infoContainerType = containerType
        super.init(frame: .zero)
        
        let stack = UIStackView(arrangedSubviews: [iconImageView, label,windImageView])
        stack.axis = .horizontal
        stack.spacing = 4
        addSubview(stack)
        stack.pinTo(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper functions
    
    func getLabelText() -> String {
        switch infoContainerType {
        case .temperature: return "\(weatherVM.tempMax)/\(weatherVM.tempMin)"
        case .humidity: return weatherVM.humidity
        case .wind: return weatherVM.windSpeed
        }
    }
}
