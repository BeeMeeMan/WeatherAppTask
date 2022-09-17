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
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    private let dateLabel = UILabel.label(withFont: 12, textColor: .white)
    private lazy var infoContainersStack = UIStackView(arrangedSubviews: infoContainers)
    private lazy var infoContainers: [InfoContainerView] = {
        var infoContainers = [InfoContainerView]()
        
        InfoContainerType.allCases.forEach { type in
            let container = InfoContainerView(weatherVM: weatherVM, containerType: type)
            infoContainers.append(container)
        }
        
        return infoContainers
    }()
    
    private lazy var heightAnchorInPortrait = heightAnchor.constraint(equalToConstant: 250)
    private lazy var heightAnchorInLandscape = heightAnchor.constraint(equalToConstant: 100)
    
    private lazy var weatherImageHeightAnchorInPortrait = weatherImage.heightAnchor.constraint(equalToConstant: 140)
    private lazy var weatherImageHeightAnchorInLandscape = weatherImage.heightAnchor.constraint(equalToConstant: 70)
    private lazy var weatherImageWidthAnchorInPortrait = weatherImage.widthAnchor.constraint(equalToConstant: 140)
    private lazy var weatherImageWidthAnchorInLandscape = weatherImage.widthAnchor.constraint(equalToConstant: 70)
    
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
        activityIndicator.removeFromSuperview()
    }
    
    func switchStateTo(_ state: DeviceOrientation) {
        switch state {
        case .portrait:
            heightAnchorInPortrait.isActive = true
            weatherImageHeightAnchorInPortrait.isActive = true
            weatherImageWidthAnchorInPortrait.isActive = true
            heightAnchorInLandscape.isActive = false
            weatherImageHeightAnchorInLandscape.isActive = false
            weatherImageWidthAnchorInLandscape.isActive = false
            self.infoContainersStack.axis = .vertical
        case .landscape:
            heightAnchorInPortrait.isActive = false
            weatherImageHeightAnchorInPortrait.isActive = false
            weatherImageWidthAnchorInPortrait.isActive = false
            heightAnchorInLandscape.isActive = true
            weatherImageHeightAnchorInLandscape.isActive = true
            weatherImageWidthAnchorInLandscape.isActive = true
            self.infoContainersStack.axis = .horizontal
        }
    }
    
    // MARK: - Helper functions
    
    private func configureUI() {
        backgroundColor = .CustomColor.darkBlue
        
        addSubview(dateLabel)
        dateLabel
            .pin(top: topAnchor)
            .pin(left: leftAnchor, padding: 12)
            .pin(right: rightAnchor)
            .closeEdit()
        
        addSubview(weatherImage)
        weatherImage
            .center(by: .yAxis, inView: self)
            .pin(top: dateLabel.bottomAnchor)
            .pin(left: leftAnchor, padding: 40)
            .closeEdit()
        
        infoContainersStack.spacing = 16
        infoContainersStack.distribution = .fill
        infoContainersStack.axis = .vertical
        
        addSubview(infoContainersStack)
        infoContainersStack
            .center(by: .yAxis, inView: self)
            .pin(left: weatherImage.rightAnchor, padding: 30)
            .closeEdit()
        
        addSubview(activityIndicator)
        activityIndicator
            .center(by: .allAxis, inView: self)
            .pinDimentions(height: 100, width: 100)
            .startAnimating()
    }
}
