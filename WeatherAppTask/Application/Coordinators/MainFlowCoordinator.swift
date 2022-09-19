//
//  MainFlowCoordinator.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import UIKit
import CoreLocation

class MainFlowCoordinator: Coordinator {
    private(set) var rootViewController = UINavigationController()
    private var location: CLLocation?
    
    private lazy var mainWeatherViewController: MainWeatherViewController = {
        let networkService = NetworkService()
        let addCityViewModel = AddCityViewModel(location: location)
        let weatherListViewModel = WeatherListViewModel(networkService: networkService)
        weatherListViewModel.handleSwitchToMap = { [weak self] in
            self?.goToPickOnMapLocationViewController()
        }
        weatherListViewModel.handleSwitchToCityPick = { [weak self] in
            self?.goToPickCityViewController()
        }
        let vc = MainWeatherViewController(weatherListVM: weatherListViewModel, addCityViewModel: addCityViewModel)
        addCityViewModel.delegate = vc
        return vc
    }()
    
    func start() {
        rootViewController.setViewControllers([mainWeatherViewController], animated: false)
    }
    
    private func pickOnMapLocationViewController() -> PickOnMapLocationViewController {
        let addCityViewModel = AddCityViewModel(location: location)
        addCityViewModel.handleGoBack = { [weak self] location in
            self?.handle(location)
            self?.goBack()
        }
        let vc = PickOnMapLocationViewController(addCityViewModel: addCityViewModel)
        return vc
    }
    
    private func pickCityViewController () -> PickCityViewController {
        let addCityViewModel = AddCityViewModel(location: location)
        addCityViewModel.handleGoBack = { [weak self] location in
            self?.handle(location)
            self?.goBack()
        }
        
        let vc = PickCityViewController(addCityViewModel: addCityViewModel)
        return vc
    }
    
    private func goToPickOnMapLocationViewController() {
        rootViewController.pushViewController(pickOnMapLocationViewController(), animated: true)
    }
    
    private func goToPickCityViewController() {
        rootViewController.pushViewController(pickCityViewController(), animated: true)
    }
    
    private func goBack() {
        _ = rootViewController.popViewController(animated: true)
    }
    
    private func handle(_ location: CLLocation?) {
        self.location = location
        DispatchQueue.main.async {
            print(location)
            self.mainWeatherViewController.weatherListVM.setLocation(location)
            self.mainWeatherViewController.weatherListVM.getWeather(completion: { isSuccess in
                if isSuccess {
                    self.mainWeatherViewController.configureViewWithListVM()
                }
            })
        }
    }
}
