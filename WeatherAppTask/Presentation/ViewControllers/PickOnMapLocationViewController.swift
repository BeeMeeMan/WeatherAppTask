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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        mapView.frame = view.frame
    }
    
    // MARK: - API
    
    func getUserLocation() {
  
        let userLocation = mapView.userLocation.coordinate
        print("###")
        print(userLocation)
        addCityViewModel.handle(userLocation) { city in
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
        mapView.userTrackingMode = .follow
        
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
//
//    private func setLocation(_ location: CLLocation) {
//            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//            self.mapView.setRegion(region, animated: true)
//    }
}
