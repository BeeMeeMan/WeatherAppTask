//
//  AppFlowCoordinator.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import UIKit

protocol Coordinator {
    func start()
}

class AppFlowCoordinator: Coordinator {
    
    // MARK: - Properties
    
    private let window: UIWindow
    private var childCoordinators = [Coordinator]()
    
    // MARK: - Coordinator
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        runMainFlow()
    }
    
    private func runMainFlow() {
        let mainCoordinator =  MainFlowCoordinator()
        mainCoordinator.start()
        childCoordinators = [mainCoordinator]
        window.rootViewController = mainCoordinator.rootViewController
    }
}
