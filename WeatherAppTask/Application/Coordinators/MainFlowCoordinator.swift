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
        weatherListViewModel.handleSwitchToMap = { [weak self] in
            self?.goToPickOnMapLocationViewController()
        }
        weatherListViewModel.handleSwitchToCityPick = { [weak self] in
            self?.goToPickCityViewController()
        }
        let vc = MainWeatherViewController(weatherListVM: weatherListViewModel)
        return vc
    }()

    private lazy var pickOnMapLocationViewController: PickOnMapLocationViewController = {

//        let weatherListViewModel = WeatherListViewModel(networkService: networkService)
//        weatherListViewModel.handleSwitchViewButton = { [weak self] in
//            self?.goToPickLocationViewController()
//        }
        let vc = PickOnMapLocationViewController()
        return vc
    }()
    
    private lazy var pickCityViewController: PickCityViewController = {

//        let weatherListViewModel = WeatherListViewModel(networkService: networkService)
//        weatherListViewModel.handleSwitchViewButton = { [weak self] in
//            self?.goToPickLocationViewController()
//        }
        let vc = PickCityViewController()
        return vc
    }()

    
    func start() {
        rootViewController.setViewControllers([profileViewController], animated: false)
    }
    
    private func goToPickOnMapLocationViewController() {
        rootViewController.pushViewController(pickOnMapLocationViewController, animated: true)
    }
    
    private func goToPickCityViewController() {
        rootViewController.pushViewController(pickCityViewController, animated: true)
    }
}
