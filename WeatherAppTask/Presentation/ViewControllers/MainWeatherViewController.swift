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
    
    private lazy var leftBarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ic_place"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleLocation), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var weatherInfoView: WeatherInfoView = {
        let weatherInfoView = WeatherInfoView(weatherVM: weatherListVM.getWeatherViewModel(at: 0))
        
        return weatherInfoView
    }()
    
    private lazy var verticalScrollView: UIScrollView = {
        let verticalScrollView = UIScrollView()
        verticalScrollView.isScrollEnabled = true
        verticalScrollView.backgroundColor = .CustomColor.lightBlue
        verticalScrollView.contentInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        verticalScrollView.contentSize = CGSize(width: 2000, height: 50)
        
        var viewStack = [UIView]()
        
        for _ in 0..<10 {
            let view = UIView()
            view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            view.backgroundColor = .red
            
            viewStack.append(view)
        }
        
        
        let stack = UIStackView(arrangedSubviews: viewStack)
        stack.setDimensions(height: 50, width: 1000)
        stack.axis = .horizontal
        stack.spacing = 12
        stack.distribution = .fillEqually
        
        
        verticalScrollView.addSubview(stack)
        stack.pinTo(view: verticalScrollView)
        
        return verticalScrollView
    }()
    
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
        configureUI()
        weatherListVM.getWeather() { isSuccess in
            if isSuccess {
                self.configureViewWithListVM()
            }
            
        }
    }
    
    // MARK: - Selectors
    
    @objc func handleLocation() {
        print("handleLocation")
    }
    
    @objc func refresh(sender: AnyObject) {
        weatherListVM.getWeather() { isSuccess in
            if isSuccess {
                self.configureViewWithListVM()
            }
            self.refreshControl.endRefreshing()
        }
    }
    
    // MARK: - API
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        configureTableView()
        configureNavigationBar()
        
        view.addSubview(weatherInfoView)
        weatherInfoView.center(by: .xAxis, inView: view)
        weatherInfoView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                               left: view.leftAnchor,
                               right: view.rightAnchor,
                               height: 180)
        weatherInfoView.weatherVM = weatherListVM.getWeatherViewModel(at: 0)
        
        view.addSubview(verticalScrollView)
        verticalScrollView.anchor(top: weatherInfoView.bottomAnchor,
                                  left: view.leftAnchor,
                                  right: view.rightAnchor,
                                  height: 60)
        
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
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_my_location"), style: .done, target: self, action: #selector(handleLocation))
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
