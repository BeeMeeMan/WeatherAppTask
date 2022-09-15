//
//  MainWeatherViewController.swift
//  WeatherAppTask
//
//  Created by Yevhenii Korsun on 14.09.2022.
//

import UIKit

private let reuseIdentifier = "WeatherCell"

class MainWeatherViewController: UIViewController {
    
    // MARK: - Properties

    private var weatherListVM: WeatherListViewModel
    private var selectedWeatherVM: WeatherViewModel? {
        didSet {
            configureViewWithVM()
        }
    }
    
    private let tableView = UITableView()
    private let refreshControl = UIRefreshControl()
    private lazy var weatherInfoHeightAnchor = weatherInfoView.heightAnchor.constraint(equalToConstant: 250)
    private lazy var weatherScrollViewHeightAnchor = weatherInfoView.heightAnchor.constraint(equalToConstant: 140)
    
    private lazy var leftBarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ic_place"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(goToPickLocationOnMapView), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var weatherInfoView: WeatherInfoView = {
        let weatherInfoView = WeatherInfoView(weatherVM: weatherListVM.getWeatherViewModel(at: 0))
        
        return weatherInfoView
    }()
    
    private lazy var verticalScrollView = WeatherScrollView(weatherListVM: [])

    // MARK: - Lifecycle
    
    init(weatherListVM: WeatherListViewModel) {
        self.weatherListVM = weatherListVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(weatherListVM: WeatherListViewModel(networkService: NetworkService()))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherInfoHeightAnchor.isActive = UIScreen.height > UIScreen.width ? true : false
        weatherScrollViewHeightAnchor.isActive = UIScreen.height > UIScreen.width ? false : true
        
        configureUI()
        weatherListVM.getWeather() { isSuccess in
            if isSuccess {
                self.configureViewWithListVM()
            }
            
        }
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        weatherInfoHeightAnchor.isActive = UIScreen.isPortrait(by: traitCollection) ? true : false
        weatherScrollViewHeightAnchor.isActive = UIScreen.isPortrait(by: traitCollection) ? false : true
    }
    
    // MARK: - Selectors
    
    @objc func goToPickLocationOnMapView() {
        weatherListVM.handleSwitchToMap()
    }
    
    @objc func goToPickCityView() {
        weatherListVM.handleSwitchToCityPick()
    }
    
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
        
        view.addSubview(weatherInfoView)
        weatherInfoView.center(by: .xAxis, inView: view)
        weatherInfoView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                               left: view.leftAnchor,
                               right: view.rightAnchor)
        weatherInfoView.weatherVM = weatherListVM.getWeatherViewModel(at: 0)
        
        view.addSubview(verticalScrollView)
        verticalScrollView.anchor(top: weatherInfoView.bottomAnchor,
                                  left: view.leftAnchor,
                                  right: view.rightAnchor,
                                  height: 140)
        
        view.addSubview(tableView)
        tableView.anchor(top: verticalScrollView.bottomAnchor,
                         bottom: view.safeAreaLayoutGuide.bottomAnchor,
                         left: view.leftAnchor,
                         right: view.rightAnchor)
    }
    
    private func configureTableView() {
        tableView.register(WeatherCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        refreshControl.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        tableView.separatorStyle = .none
        tableView.rowHeight = 60
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
    
    private func configureViewWithListVM() {
        DispatchQueue.main.async {
            self.leftBarButton.setTitle("  \(self.weatherListVM.cityName)", for: .normal)
            self.selectedWeatherVM = self.weatherListVM.getWeatherViewModel(at: 0)
            self.tableView.reloadData()
            self.configureNavigationBar()
            self.verticalScrollView.setWeather(viewModel: self.weatherListVM.list)
            self.weatherListVM.list.indices.forEach { index in
                (self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? WeatherCell)?.cellState = .inactive
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
