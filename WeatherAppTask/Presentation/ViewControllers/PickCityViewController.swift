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
    
    private var addCityViewModel: AddCityViewModel
    private let searchBar: UISearchBar = UISearchBar()
    
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
    
    @objc private func handlePickCity() { addCityViewModel.handleGoBack(addCityViewModel.city) }
    @objc private func handleGoBack() { addCityViewModel.handleGoBack("") }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        configureNavigationBar()
        configureSearchController()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.separatorStyle = .none
    }
    
    private func configureNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_search"), style: .done, target: self, action: #selector(handlePickCity))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_back"), style: .done, target: self, action: #selector(handleGoBack))
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
        return addCityViewModel.numberOfRowsInSection(section: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = addCityViewModel.getSearchResult(at: indexPath)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont.systemFont(ofSize: 24)
        
        return cell
    }
}

// MARK: - Table view delegates

extension PickCityViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        addCityViewModel.addCity(at: indexPath)
    }
}

// MARK: - UISearchBarDelegate

extension PickCityViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        addCityViewModel.searchBy(searchText: searchText) { [weak self] in
            self?.tableView.reloadDataOnMainThread()
        }
    }
}
