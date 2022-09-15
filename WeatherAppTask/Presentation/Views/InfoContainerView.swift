//
//  InfoContainer.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import UIKit

enum InfoContainerType: CaseIterable {
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

class InfoContainerView: UIView {
    
    // MARK: - Properties
    
    private let iconWidth: CGFloat = 16
    private let iconHeight: CGFloat = 20
    private var weatherVM: WeatherViewModel?
    private let infoContainerType: InfoContainerType
    
    private lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: infoContainerType.iconName)
        image.tintColor = .white
        image.setDimensions(height: iconHeight, width: iconWidth)
        
        return image
    }()
    
    private lazy var windImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: weatherVM?.windDirection.iconName ?? "")
        image.tintColor = .white
        image.setDimensions(height: iconHeight, width: iconWidth)
        
        return image
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .white
        label.textAlignment = .left
        label.text = getLabelText()

        return label
    }()
    
    // MARK: - Lifecycle
    
    init(weatherVM: WeatherViewModel?, containerType: InfoContainerType) {
        self.weatherVM = weatherVM
        self.infoContainerType = containerType
        super.init(frame: .zero)
        
        let stack = UIStackView(arrangedSubviews: [iconImageView, label,windImageView])
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 4
        addSubview(stack)
        stack.pinTo(view: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    
    func setWeather(viewModel: WeatherViewModel) {
        weatherVM = viewModel
        if infoContainerType == .wind {
            windImageView.image = UIImage(named: viewModel.windDirection.iconName)
        }
        label.text = getLabelText()
    }
    
    // MARK: - Helper functions
    
    private func getLabelText() -> String {
        if let weatherVM = weatherVM {
            switch infoContainerType {
            case .temperature: return "\(weatherVM.tempMax)/\(weatherVM.tempMin)"
            case .humidity: return weatherVM.humidity
            case .wind: return weatherVM.windSpeed
            }
        } else {
            return ""
        }
    }
}
