//
//  WeatherCell.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 15.09.2022.
//

import UIKit

enum CellState {
    case active
    case inactive
}

class WeatherCell: UITableViewCell {
    
    // MARK: - Properties
    
    var cellState: CellState = .inactive {
        didSet { configureUI() }
    }
    
    var weatherVM: WeatherViewModel? {
        didSet { configureUI() }
    }
    
    private let dayLabel = UILabel.label(withFont: 28)
    private let tempLabel = UILabel.label(withFont: 28)
    private let iconImageView = UIImageView()
    private let newBackgroundView = UIView()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        
        addSubview(newBackgroundView)
        newBackgroundView
            .pin(top: topAnchor, padding: 5)
            .pin(bottom: bottomAnchor, padding: 5)
            .pin(left: leftAnchor)
            .pin(right: rightAnchor)
            .backgroundColor = .white
        
        addSubview(dayLabel)
        dayLabel
            .center(by: .yAxis, inView: self)
            .pin(left: leftAnchor, padding: 12)
            .closeEdit()
        
        addSubview(iconImageView)
        iconImageView
            .pinDimentions(height: 30, width: 30)
            .center(by: .yAxis, inView: self)
            .pin(right: rightAnchor, padding: 12)
            .closeEdit()
        
        
        addSubview(tempLabel)
        tempLabel.center(by: .allAxis, inView: self).closeEdit()
        
        layer.shadowColor = UIColor.CustomColor.lightBlue.cgColor
        layer.shadowRadius = 15
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.masksToBounds = true
        layer.shouldRasterize = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper functions
    
    private func configureUI() {
        guard let weatherVM = weatherVM else { return }
        DispatchQueue.main.async {
            self.dayLabel.text = weatherVM.dayOfWeek
            self.tempLabel.text = "\(weatherVM.tempMax) / \(weatherVM.tempMin)"
            
            let mainColor = self.cellState == .active ? UIColor.CustomColor.lightBlue : .black
            self.dayLabel.textColor = mainColor
            self.tempLabel.textColor = mainColor
            self.iconImageView.image = UIImage(named: weatherVM.weatherType.iconName)?.withRenderingMode(.alwaysTemplate)
            self.iconImageView.tintColor = mainColor
            
            self.layer.shadowOpacity = self.cellState == .active ? 0.25 : 0
        }
    }
}
