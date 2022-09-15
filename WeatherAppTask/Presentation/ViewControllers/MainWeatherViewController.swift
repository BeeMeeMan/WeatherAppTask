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
    
    private var weatherListVM: WeatherListViewModel? {
        didSet {
            configureViewWithListVM()
        }
    }
    
    private var selectedWeatherVM: WeatherViewModel? {
        didSet {
            configureViewWithVM()
        }
    }
    
    private let tableView = UITableView()
    
    private lazy var leftBarButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ic_place"), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleLocation), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var weatherInfoView: WeatherInfoView = {
        let weatherInfoView = WeatherInfoView(weatherVM: weatherListVM?.getWeatherViewModel(at: 0))
        
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
        print("#\(stack.subviews)")
        
        return verticalScrollView
    }()
    
    // MARK: - Lifecycle
    
    init(weatherListVM: WeatherListViewModel?) {
        self.weatherListVM = weatherListVM
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init(weatherListVM: WeatherListViewModel(weatherListResponce: WeatherListResponce(list: [], city: City(name: ""))))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let weatherURL = NetworkConfig.Urls.urlForWeatherList(by: "Харків") {
            let resource = Resource<WeatherListResponce>(url: weatherURL) { data in
                return try? JSONDecoder().decode(WeatherListResponce.self, from: data)
            }
            
            NetworkService().load(resource: resource) { result in
                if result != nil {
                    DispatchQueue.main.async {
                        print(result)
                        if let result = result {
                            self.weatherListVM = WeatherListViewModel(weatherListResponce: result)
                        }
                        
                        self.configureViewWithListVM()
                    }
                }
            }
        }
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleLocation() {
        print("handleLocation")
    }
    
    // MARK: - API
    
    // MARK: - Helper Functions
    
    private func configureUI() {
        configureTableView()
        configureNavigationBar()
        
        view.addSubview(weatherInfoView)
        weatherInfoView.center(by: .xAxis, inView: view)
        weatherInfoView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                               left: view.safeAreaLayoutGuide.leftAnchor,
                               right: view.safeAreaLayoutGuide.rightAnchor,
                               height: 180)
        weatherInfoView.weatherVM = weatherListVM?.getWeatherViewModel(at: 0)
        
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBarButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_my_location"), style: .done, target: self, action: #selector(handleLocation))
    }
    
    private func configureViewWithVM() {
        guard let weatherVM = selectedWeatherVM else { return }
        weatherInfoView.setWeather(viewModel: weatherVM)
    }
    
    private func configureViewWithListVM() {
        guard let weatherListVM = weatherListVM else { return }
        leftBarButton.setTitle("  \(weatherListVM.cityName)", for: .normal)
        selectedWeatherVM = weatherListVM.getWeatherViewModel(at: 0)
        tableView.reloadData()
    }
}

// MARK: - Table view data source

extension MainWeatherViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return weatherListVM?.numberOfRowsInSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        cell.textLabel?.text = weatherListVM?.getWeatherViewModel(at: indexPath.row).tempMin
        return cell
    }
}

// MARK: - Table view delegates

extension MainWeatherViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedWeatherVM = weatherListVM?.getWeatherViewModel(at: indexPath.row)
    }
}
