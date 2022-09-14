//
//  MainFlowCoordinator.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import UIKit

class MainFlowCoordinator: Coordinator {
    private(set) var rootViewController = UINavigationController()
    
    private lazy var profileViewController: MainWeatherViewController = {
        let vc = MainWeatherViewController()
        vc.title = "weather"
        return vc
    }()

    func start() {
        rootViewController.setViewControllers([profileViewController], animated: false)
    }
}
