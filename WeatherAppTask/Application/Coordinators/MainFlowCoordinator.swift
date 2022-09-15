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
        let networkService = NetworkService()
        let weatherListViewModel = WeatherListViewModel(networkService: networkService)
        weatherListViewModel.handleSwitchViewButton = { [weak self] in
            self?.goToPickLocationViewController()
        }
        let vc = MainWeatherViewController(weatherListVM: weatherListViewModel)
        return vc
    }()

    private lazy var pickLocationViewController: PickLocationViewController = {

//        let weatherListViewModel = WeatherListViewModel(networkService: networkService)
//        weatherListViewModel.handleSwitchViewButton = { [weak self] in
//            self?.goToPickLocationViewController()
//        }
        let vc = PickLocationViewController()
        return vc
    }()

    
    func start() {
        rootViewController.setViewControllers([profileViewController], animated: false)
    }
    
    private func goToPickLocationViewController() {
        rootViewController.pushViewController(pickLocationViewController, animated: true)
    }
}
