//
//  WeatherStateView.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 15.09.2022.
//

import UIKit

class WeatherDetailView: UIView {
    
    // MARK: - Properties

    private var weatherVM: WeatherViewModel
    private let timeLabel = UILabel.label(withFont: 18, textColor: .white)
    private let tempLabel = UILabel.label(withFont: 20, textColor: .white)
    private let iconView = UIImageView.imageView(height: 34, width: 34)
    
    // MARK: - Lifecycle
    
    init(weatherVM: WeatherViewModel) {
        self.weatherVM = weatherVM
        super.init(frame: .zero)
        backgroundColor = .CustomColor.lightBlue
        
        addSubview(timeLabel)
        timeLabel.center(by: .xAxis, inView: self)
        timeLabel.anchor(top: topAnchor, paddingTop: 20)
        
        addSubview(iconView)
        iconView.center(by: .allAxis, inView: self)
//        iconView.anchor(bottom: tempLabel.topAnchor, paddingBottom: 4)
        
        addSubview(tempLabel)
        tempLabel.center(by: .xAxis, inView: self)
        tempLabel.anchor(top: iconView.bottomAnchor, paddingBottom: 8)
        
        timeLabel.text = "\(weatherVM.time)"
        tempLabel.text = weatherVM.temp
        iconView.image = UIImage(named: weatherVM.weatherType.iconName)
        setDimensions(height: 140, width: 60)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
