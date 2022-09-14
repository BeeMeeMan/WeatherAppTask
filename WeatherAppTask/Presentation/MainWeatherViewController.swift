//
//  MainWeatherViewController.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import UIKit

private let reuseIdentifier = "WeatherCell"

class MainWeatherViewController: UITableViewController {
    
    // MARK: - Properties
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        let weatherURL = Urls.urlForWeatherByCity(city: "Kharkiv")
        let resource = Resource<WeatherResponce>(url: weatherURL) { data in
            return try? JSONDecoder().decode(WeatherResponce.self, from: data)
        }
        let text = "clear sky"
        print(text.removeSpacesAddUppercase())
        NetworkService().load(resource: resource) { result in
            if let weatherResource = result {
                print(result)
            }
        }
    }
    
    // MARK: - Selectors
    
    // MARK: - API
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}

// MARK: - Table view data source

extension MainWeatherViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        return cell
    }
}

// MARK: - Table view delegates

extension MainWeatherViewController {
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        print("#accessoryButtonTappedForRowWith")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("#didSelectRowAt")
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

