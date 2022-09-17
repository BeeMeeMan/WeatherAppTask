//
//  WeatherScrollView.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 15.09.2022.
//

import UIKit

class WeatherScrollView: UIScrollView {
    
    // MARK: - Properties
    
    private var weatherListVM: [WeatherViewModel]
    
    // MARK: - Lifecycle
    
    init(weatherListVM: [WeatherViewModel]) {
        self.weatherListVM = weatherListVM
        super.init(frame: .zero)
        isScrollEnabled = true
        backgroundColor = .CustomColor.lightBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - API
    
    func setWeather(viewModel: [WeatherViewModel]) {
        weatherListVM = viewModel
    
        subviews.map { $0.removeFromSuperview() }
        var viewStack = [UIView]()
        weatherListVM.forEach { weatherVM in
            let view = WeatherDetailView(weatherVM: weatherVM)
            viewStack.append(view)
        }
        
        let stack = UIStackView.hStack(subviews: viewStack, spacing: 12, distribution: .fillEqually)
        addSubview(stack)
        stack.pinAll(view: self)
    }
}
