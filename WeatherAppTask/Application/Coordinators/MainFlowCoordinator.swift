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
        let pickPositionViewModel = PickPositionViewModel()
        pickPositionViewModel.handleGoBack = { [weak self] in
            self?.goBack()
        }
        let vc = PickOnMapLocationViewController(pickPositionViewModel: pickPositionViewModel)
        return vc
    }()
    
    private lazy var pickCityViewController: PickCityViewController = {
        let pickPositionViewModel = PickPositionViewModel()
        pickPositionViewModel.handleGoBack = { [weak self] in
            self?.goBack()
        }
        let vc = PickCityViewController(pickPositionViewModel: pickPositionViewModel)
        return vc
    }()

    
    func start() {
        rootViewController.setViewControllers([profileViewController], animated: false)
    }
    
    private func goToPickOnMapLocationViewController() {
        print("Map")
        rootViewController.pushViewController(pickOnMapLocationViewController, animated: true)
    }
    
    private func goToPickCityViewController() {
        print("CIty")
        rootViewController.pushViewController(pickCityViewController, animated: true)
    }
    
    private func goBack() {
            _ = rootViewController.popViewController(animated: true)
    }
}
