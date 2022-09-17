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
    
    private let iconSize: CGSize = CGSize(width: 14, height: 20)
    private var weatherVM: WeatherViewModel?
    private let infoContainerType: InfoContainerType
    private lazy var iconImageView = UIImageView.imageView(size: iconSize)
    private lazy var windImageView = UIImageView.imageView(size: iconSize)
    private lazy var label = UILabel.label(withFont: 18, textColor: .white)

    // MARK: - Lifecycle
    
    init(weatherVM: WeatherViewModel?, containerType: InfoContainerType) {
        self.weatherVM = weatherVM
        self.infoContainerType = containerType
        super.init(frame: .zero)
        
        iconImageView.image = UIImage(named: containerType.iconName)
        let stack = UIStackView.hStack(subviews: [iconImageView, label, windImageView], spacing: 4)
        addSubview(stack)
        stack.pinAll(view: self)
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
