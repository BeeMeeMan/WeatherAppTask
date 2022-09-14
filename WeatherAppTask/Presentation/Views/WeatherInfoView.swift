////
////  CurrentWeatherView.swift
////  WeatherAppTask
////
////  Created by Yevhenii Korsun on 14.09.2022.
////
//
//import UIKit
//
//class WeatherInfoView: UIView {
//
//    private let weather: WeatherViewModel
//    
//    private lazy var weatherImage: UIImageView = {
//        let iv = UIImageView()
//        let image = UIImage(systemName: weather.weatherType.iconName)?.withTintColor(.Custom.white, renderingMode: .alwaysOriginal)
//        iv.image = image
//        
//        return iv
//    }()
//    
//    private lazy var dateLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 12)
//        label.textColor = UIColor.Custom.white
//        label.text = weather.date
//        
//        return label
//    }()
//    
//    // MARK: - Lifecycle
//    
//    init(weather: WeatherViewModel) {
//        self.weather = weather
//        configureUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // MARK: - Selectors
//    
//    // MARK: - Helper functions
//    
//    func configureUI() {
//        addSubview(profileImageView)
//        profileImageView.anchor(top: topAnchor,
//                                left: leftAnchor,
//                                paddingTop: 40,
//                                paddingLeft: 12,
//                                width: 64,
//                                height: 64)
//        profileImageView.layer.cornerRadius = 64 / 2
//        
//        
//        let stack = UIStackView(arrangedSubviews: [fullNameLabel, emailLabel])
//        stack.distribution = .fillEqually
//        stack.spacing = 4
//        stack.axis = .vertical
//        addSubview(stack)
//        stack.center(by: .YAxis,
//                     inView: profileImageView,
//                     leftAnchor: profileImageView.rightAnchor,
//                     paddingLeft: 12)
//    }
//}
