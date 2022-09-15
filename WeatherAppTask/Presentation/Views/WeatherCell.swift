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
        didSet {
            configureUI()
        }
    }
    
    var weatherVM: WeatherViewModel? {
        didSet {
            configureUI()
        }
    }
    
    var dayLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        
        return label
    }()
    
    var tempLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        
        return label
    }()
    
    private lazy var iconImageView: UIImageView = {
        let image = UIImageView()
        image.setDimensions(height: 30, width: 30)
        
        return image
    }()

    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         addSubview(dayLabel)
        dayLabel.center(by: .yAxis, inView: self)
        dayLabel.anchor(left: leftAnchor, paddingLeft: 12)
        
        addSubview(iconImageView)
        iconImageView.center(by: .yAxis, inView: self)
        iconImageView.anchor(right: rightAnchor, paddingRight: 12)
        
        addSubview(tempLabel)
        tempLabel.center(by: .allAxis, inView: self)
        
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper functions
    
    private func configureUI() {
        guard let weatherVM = weatherVM else { return }
        DispatchQueue.main.async {
            self.backgroundColor = self.cellState == .active ? UIColor.CustomColor.offWhite : .white
            
            self.dayLabel.text = weatherVM.dayOfWeek
            self.tempLabel.text = "\(weatherVM.tempMax) / \(weatherVM.tempMin)"
           
            let mainColor = self.cellState == .active ? UIColor.CustomColor.lightBlue : .black
            self.dayLabel.textColor = mainColor
            self.tempLabel.textColor = mainColor
            self.iconImageView.image = UIImage(named: weatherVM.weatherType.iconName)?.withRenderingMode(.alwaysTemplate)
            self.iconImageView.tintColor = mainColor
        }
    }
}
