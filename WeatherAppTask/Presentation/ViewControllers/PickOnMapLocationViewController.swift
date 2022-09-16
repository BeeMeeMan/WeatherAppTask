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
    
    private var addCityViewModel: AddCityViewModel
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    
    // MARK: - Lifecycle
    
    init(addCityViewModel: AddCityViewModel) {
        self.addCityViewModel = addCityViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(addCityViewModel: AddCityViewModel())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        enableLocationServices()
    }
    
    // MARK: - Selectors
    
    @objc private func handlePickCity() { addCityViewModel.handleGoBack(addCityViewModel.location) }
    @objc private func handleGoBack() { addCityViewModel.handleGoBack(nil) }
    @objc private func revealRegionDetailsWithLongPressOnMap(sender: UILongPressGestureRecognizer) {
        if sender.state != UIGestureRecognizer.State.began { return }
        removeAnnotationsAndOverlays()
        let touchLocation = sender.location(in: mapView)
        let locationCoordinate = mapView.convert(touchLocation, toCoordinateFrom: mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = locationCoordinate
        mapView.addAnnotation(annotation)
        mapView.selectAnnotation(annotation, animated: true)
        mapView.addAnnotation(annotation)
        
        addCityViewModel.handle(locationCoordinate) { city in
            DispatchQueue.main.async {
                self.title = city
            }
        }
    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        configureMapView()
        configureNavigationBar()
    }
    
    private func configureMapView() {
        view.addSubview(mapView)
        mapView.frame = view.frame
        mapView.showsUserLocation = true
        setLocation() 
        
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(revealRegionDetailsWithLongPressOnMap))
        mapView.addGestureRecognizer(longPressRecognizer)
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_search"), style: .done, target: self, action: #selector(handlePickCity))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_back"), style: .done, target: self, action: #selector(handleGoBack))
    }
    
    private func removeAnnotationsAndOverlays() {
        mapView.annotations.forEach { annotation in
            mapView.removeAnnotation(annotation)
        }
    }
    
    private func setLocation() {
        if let location = addCityViewModel.location {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
        }
    }
}

// MARK: - CLLocationManagerDelegate

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
