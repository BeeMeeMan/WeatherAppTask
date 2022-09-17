//
//  PickPositionViewModel.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 15.09.2022.
//

import Foundation
import MapKit

protocol AddCityViewModelDelegate: AnyObject {
    func addCityViewModel(get location: CLLocation?)
}

class AddCityViewModel: NSObject {
    private let locationManager = CLLocationManager()
    private var searchResults = [MKPlacemark]()
    private var isFirstScreenLoad = true
    weak var location: CLLocation?
    
    weak var delegate: AddCityViewModelDelegate?
    var handleGoBack: (CLLocation?) -> Void = { location in }
    
    init(location: CLLocation? = nil) {
        self.location = location
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return searchResults.count
    }
    
    func addCity(at indexPath: IndexPath) {
        if let location = searchResults[indexPath.row].location {
            self.location = location
        }
    }
    
    func getLocation() {
        locationManager.requestLocation()
        isFirstScreenLoad = false
    }
    
    func handle(_ locationCoordinate: CLLocationCoordinate2D, completion: @escaping(String) -> Void) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: locationCoordinate.latitude, longitude: locationCoordinate.longitude)
        self.location = location
        geoCoder.reverseGeocodeLocation(location, completionHandler:
                                            {
            placemarks, error -> Void in
            guard let placeMark = placemarks?.first else { return }
            if let city = placeMark.subAdministrativeArea {
                completion(city)
            }
        })
    }
    
    func getSearchResult(at indexPath: IndexPath) -> String {
        guard searchResults.indices.contains(indexPath.row) else { return "No data" }
        if let city = searchResults[indexPath.row].locality {
            let country = searchResults[indexPath.row].country ?? ""
            return "\(city)  \(country)"
        } else {
            return "No data"
        }
    }
    
    func searchBy(searchText: String, completion: @escaping() -> Void) {
        var results = [MKPlacemark]()
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText
        
        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let response = response else { return }
            
            response.mapItems.forEach { item in
                results.append(item.placemark)
            }
            
            self?.searchResults = results
            
            completion()
        }
    }
}

// MARK: - CLLocationManagerDelegate

extension AddCityViewModel: CLLocationManagerDelegate {
    
    func enableLocationServices() {
        locationManager.delegate = self
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            break
        case .authorizedAlways:
            if isFirstScreenLoad { getLocation() }
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
            if isFirstScreenLoad { getLocation() }
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            delegate?.addCityViewModel(get: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
}
