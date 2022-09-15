//
//  PickMapLocationViewController.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 15.09.2022.
//

import UIKit
import MapKit

class PickOnMapLocationViewController: UIViewController {
    
    // MARK: - Properties
    
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    
    private let searchController = UISearchController(searchResultsController: nil)
    lazy   var searchBar: UISearchBar = UISearchBar()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        configureUI()
        enableLocationServices()
        configureNavigationBar()
        
    }
    
    // MARK: - Selectors
    
    @objc private func handlePickCity() {
        print("#handlePickCity")
    }
    
    @objc private func handleGoBack() {
        print("#handlePickCity")
    }
    
    // MARK: - API
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        configureMapView()
        
    }
    
    private func configureMapView() {
        view.addSubview(mapView)
        mapView.frame = view.frame
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    private func configureNavigationBar() {
        searchBar.placeholder = "Enter city name"
//        searchBar = .white
        navigationItem.titleView = searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_search"), style: .done, target: self, action: #selector(handlePickCity))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_back"), style: .done, target: self, action: #selector(handleGoBack))
    }
    
    private func configureSearchController() {
        navigationController?.navigationBar.topItem?.searchController?.isActive = true
        searchController.searchBar.showsCancelButton = false
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search for a user"
        definesPresentationContext = false
        
        if let textField = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .systemPurple
            textField.backgroundColor = .white
        }
    }
}

// MARK: - LocationServises

extension PickOnMapLocationViewController: CLLocationManagerDelegate {
    func enableLocationServices() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("# Not determined")
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways:
            print("# Auth always")
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            print("# Auth when in use")
            locationManager.requestAlwaysAuthorization()
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
}

// MARK: - UISearchResultsUpdating

extension PickOnMapLocationViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }
        
    }
}
