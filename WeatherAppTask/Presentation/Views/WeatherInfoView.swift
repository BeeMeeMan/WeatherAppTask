//
//  CurrentWeatherView.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import UIKit

class WeatherInfoView: UIView {

    var weatherVM: WeatherViewModel?
    
    private let weatherImage = UIImageView()
    private let dateLabel = UILabel.label(withFont: 12, textColor: .white)
    private lazy var infoContainers: [InfoContainerView] = {
        var infoContainers = [InfoContainerView]()
        
        InfoContainerType.allCases.forEach { type in
            let container = InfoContainerView(weatherVM: weatherVM, containerType: type)
            infoContainers.append(container)
        }

        return infoContainers
    }()
    
    // MARK: - Lifecycle
    
    init(weatherVM: WeatherViewModel?) {
        self.weatherVM = weatherVM
        super.init(frame: .zero)
       
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    
    func setWeather(viewModel: WeatherViewModel) {
        weatherVM = viewModel
        infoContainers.forEach { container in
            container.setWeather(viewModel: viewModel)
        }
        
        weatherImage.image = UIImage(named: weatherVM?.weatherType.iconName ?? "")
        dateLabel.text = viewModel.date
    }
    
    // MARK: - Helper functions
    
    private func configureUI() {
        backgroundColor = .CustomColor.darkBlue
        
        addSubview(dateLabel)
        dateLabel.anchor(top: topAnchor,
                         left: leftAnchor,
                         right: rightAnchor,
                         paddingLeft: 12)

        addSubview(weatherImage)
        weatherImage.center(by: .yAxis, inView: self)
        weatherImage.anchor(top: dateLabel.bottomAnchor,
                            left: leftAnchor,
                            paddingLeft: 40,
                            width: 140,
                            height: 140)

        let infoContainersStack = UIStackView(arrangedSubviews: infoContainers)
        infoContainersStack.axis = .vertical
        infoContainersStack.spacing = 16
        addSubview(infoContainersStack)
        infoContainersStack.center(by: .yAxis, inView: self)
        infoContainersStack.anchor(left: weatherImage.rightAnchor,
                                   paddingLeft: 30)
    }
}
