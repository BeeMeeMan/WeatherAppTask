//
//  MainWeatherViewController.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import UIKit
import MapKit

private let reuseIdentifier = "WeatherCell"

class MainWeatherViewController: UIViewController {
    
    // MARK: - Properties
    
    private var addCityViewModel: AddCityViewModel
    var weatherListVM: WeatherListViewModel
    private var selectedWeatherVM: WeatherViewModel? {
        didSet { configureViewWithVM() }
    }
    
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private lazy var weatherInfoView = WeatherInfoView(weatherVM: weatherListVM.getWeatherViewModel(at: 0))
    private lazy var verticalScrollView = WeatherScrollView(weatherListVM: weatherListVM.list)
    private lazy var leftBarButton = UIButton.button()
        .lzSetImage(UIImage(named: "ic_place"))
        .lzAddTarget(self, selector: #selector(goToPickLocationOnMapView))
        .lzSetTitle(color: .white, font: .systemFont(ofSize: 24))
    
    // MARK: - Lifecycle
    
    init(weatherListVM: WeatherListViewModel, addCityViewModel: AddCityViewModel) {
        self.weatherListVM = weatherListVM
        self.addCityViewModel = addCityViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(weatherListVM: WeatherListViewModel(networkService: NetworkService()), addCityViewModel: AddCityViewModel())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addCityViewModel.enableLocationServices()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        weatherInfoView.switchStateTo(UIScreen.getOrientation1())
    }
    
    // MARK: - Selectors
    
    @objc func goToPickLocationOnMapView() { weatherListVM.handleSwitchToMap() }
    @objc func goToPickCityView() { weatherListVM.handleSwitchToCityPick() }
    @objc func refresh(sender: AnyObject) {
        weatherListVM.getWeather() { isSuccess in
            if isSuccess {
                self.configureViewWithListVM()
            }
            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        configureTableView()
        configureNavigationBar()
        weatherInfoView.switchStateTo(UIScreen.getOrientation1())
        
        view.addSubview(weatherInfoView)
        weatherInfoView
            .center(by: .xAxis, inView: view)
            .pin(top: view.safeAreaLayoutGuide.topAnchor)
            .pin(left: view.leftAnchor)
            .pin(right: view.rightAnchor)
            .weatherVM = weatherListVM.getWeatherViewModel(at: 0)
        
        view.addSubview(verticalScrollView)
        verticalScrollView
            .pin(top: weatherInfoView.bottomAnchor)
            .pin(left: view.leftAnchor)
            .pin(right: view.rightAnchor)
            .pinDimentions(height: 140)
            .closeEdit()
        
        view.addSubview(tableView)
        tableView
            .pin(top: verticalScrollView.bottomAnchor)
            .pin(left: view.leftAnchor)
            .pin(right: view.rightAnchor)
            .pin(bottom: view.safeAreaLayoutGuide.bottomAnchor)
            .closeEdit()
    }
    
    private func configureTableView() {
        tableView.register(WeatherCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
        tableView.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_my_location"), style: .done, target: self, action: #selector(goToPickCityView))
    }
    
    private func configureViewWithVM() {
        guard let weatherVM = selectedWeatherVM else { return }
        DispatchQueue.main.async {
            self.weatherInfoView.setWeather(viewModel: weatherVM)
        }
    }
    
    func configureViewWithListVM() {
        DispatchQueue.main.async {
            self.leftBarButton.setTitle("  \(self.weatherListVM.cityName)", for: .normal)
            self.selectedWeatherVM = self.weatherListVM.getWeatherViewModel(at: 0)
            self.configureNavigationBar()
            self.verticalScrollView.setWeather(viewModel: self.weatherListVM.list)
            self.weatherListVM.list.indices.forEach { index in
                (self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? WeatherCell)?.cellState = .inactive
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - Table view data source

extension MainWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherListVM.numberOfRowsInSectionFromThreeHourInterval(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? WeatherCell else { return UITableViewCell() }
        cell.weatherVM = weatherListVM.getWeatherViewModelFromThreeHourInterval(at: indexPath.row)
        
        return cell
    }
}

// MARK: - Table view delegates

extension MainWeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        (tableView.cellForRow(at: indexPath) as? WeatherCell)?.cellState = .inactive
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedWeatherVM = weatherListVM.getWeatherViewModel(at: indexPath.row)
        (tableView.cellForRow(at: indexPath) as? WeatherCell)?.cellState = .active
    }
}

// MARK: - AddCityViewModelDelegate

extension MainWeatherViewController: AddCityViewModelDelegate {
    func addCityViewModel(get location: CLLocation?) {
        DispatchQueue.main.async {
            self.weatherListVM.setLocation(location)
            self.weatherListVM.getWeather() { isSuccess in
                if isSuccess {
                    self.configureViewWithListVM()
                }
            }
        }
    }
}
