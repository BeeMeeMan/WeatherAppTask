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
    private let iconView = UIImageView()
    
    // MARK: - Lifecycle
    
    init(weatherVM: WeatherViewModel) {
        self.weatherVM = weatherVM
        super.init(frame: .zero)
        backgroundColor = .CustomColor.lightBlue
        
        addSubview(timeLabel)
        timeLabel
            .center(by: .xAxis, inView: self)
            .pin(top: topAnchor, padding: 20)
            .closeEdit()
        
        addSubview(iconView)
        iconView
            .pinDimentions(height: 34, width: 34)
            .center(by: .allAxis, inView: self)
            .closeEdit()
        
        addSubview(tempLabel)
        tempLabel
            .center(by: .xAxis, inView: self)
            .pin(top: iconView.bottomAnchor, padding: 8)
            .closeEdit()
        
        timeLabel.text = "\(weatherVM.time)"
        tempLabel.text = weatherVM.temp
        iconView.image = UIImage(named: weatherVM.weatherType.iconName)
        pinDimentions(height: 140, width: 60).closeEdit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
