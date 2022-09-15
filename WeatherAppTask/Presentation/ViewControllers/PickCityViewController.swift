//
//  PickCityViewController.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 15.09.2022.
//

import UIKit
import MapKit

private let reuseIdentifier = "SearchCityCell"

class PickCityViewController: UITableViewController {
    
    // MARK: - Properties
    
    private var pickPositionViewModel: PickPositionViewModel
    private lazy var searchBar: UISearchBar = UISearchBar()
    private var searchResults = [MKPlacemark]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Lifecycle
    
    init(pickPositionViewModel: PickPositionViewModel) {
        self.pickPositionViewModel = pickPositionViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(pickPositionViewModel: PickPositionViewModel())
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorStyle = .none
    }
    
    // MARK: - Selectors
    
    @objc private func handlePickCity() {
        print("#handlePickCity")
    }
    
    @objc private func handleGoBack() {
        pickPositionViewModel.handleGoBack()
    }
    
    // MARK: - API
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        configureNavigationBar()
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_search"), style: .done, target: self, action: #selector(handlePickCity))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_back"), style: .done, target: self, action: #selector(handleGoBack))
        
        configureSearchController()
    }
    
    private func configureSearchController() {
        searchBar.placeholder = "Enter city name"
        navigationItem.titleView = searchBar
        searchBar.showsCancelButton = false
        searchBar.delegate = self
        
        if let textField = searchBar.value(forKey: "searchField") as? UITextField {
            textField.textColor = .CustomColor.darkBlue
            textField.backgroundColor = .white
        }
    }
}

// MARK: - Table view data source

extension PickCityViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return searchResults.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
       if let city = searchResults[indexPath.row].locality,
          let country = searchResults[indexPath.row].country {
        cell.textLabel?.text = "\(city)  \(country)"
       }
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24)
        
        return cell
    }
}

// MARK: - Table view delegates

extension PickCityViewController {
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - UISearchBarDelegate

extension PickCityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBy(naturalLanguageQuery: searchText) { results in
            self.searchResults = results
        }
    }
    
}

// MARK: - Helpers

private extension PickCityViewController {
    func searchBy(naturalLanguageQuery: String, completion: @escaping([MKPlacemark]) -> Void) {
        var results = [MKPlacemark]()
        
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = naturalLanguageQuery
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else { return }
            
            response.mapItems.forEach { item in
                results.append(item.placemark)
            }
            
            completion(results)
        }
    }
}
