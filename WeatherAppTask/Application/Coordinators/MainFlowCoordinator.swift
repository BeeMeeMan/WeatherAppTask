//
//  MainFlowCoordinator.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import UIKit

class MainFlowCoordinator: Coordinator {
    private(set) var rootViewController = UINavigationController()
    
    private lazy var mainWeatherViewController: MainWeatherViewController = {
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
        let pickPositionViewModel = AddCityViewModel()
        pickPositionViewModel.handleGoBack = { [weak self] city in
            self?.goBack()
        }
        let vc = PickOnMapLocationViewController(pickPositionViewModel: pickPositionViewModel)
        return vc
    }()
    
    private lazy var pickCityViewController: PickCityViewController = {
        let addCityViewModel = AddCityViewModel()
        addCityViewModel.handleGoBack = { [weak self] city in
            DispatchQueue.main.async {
                self?.mainWeatherViewController.weatherListVM.setCity(city)
                self?.mainWeatherViewController.weatherListVM.getWeather(completion: { isSuccess in
                    if isSuccess {
                        self?.mainWeatherViewController.configureViewWithListVM()
                    }
                })
            }
            self?.goBack()
        }
        let vc = PickCityViewController(addCityViewModel: addCityViewModel)
        return vc
    }()
    
    
    func start() {
        rootViewController.setViewControllers([mainWeatherViewController], animated: false)
    }
    
    private func goToPickOnMapLocationViewController() {
        rootViewController.pushViewController(pickOnMapLocationViewController, animated: true)
    }
    
    private func goToPickCityViewController() {
        rootViewController.pushViewController(pickCityViewController, animated: true)
    }
    
    private func goBack() {
        _ = rootViewController.popViewController(animated: true)
    }
}
