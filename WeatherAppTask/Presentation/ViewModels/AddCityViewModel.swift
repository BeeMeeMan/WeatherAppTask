//
//  PickPositionViewModel.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 15.09.2022.
//

import Foundation
import MapKit

class AddCityViewModel {
    var city = "Kiev"
    private var searchResults = [MKPlacemark]()
    
    var handleGoBack: (String) -> Void = { city in }
    
    init() { }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return searchResults.count
    }
    
    func addCity(at indexPath: IndexPath) {
        if let city = searchResults[indexPath.row].locality {
            self.city = city
        }
    }
    
    func getSearchResult(at indexPath: IndexPath) -> String {
        if let city = searchResults[indexPath.row].locality,
           let country = searchResults[indexPath.row].country {
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
