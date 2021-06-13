//
//  HomeVC.swift
//  WeatherApp
//
//  Created by Manish on 10/06/21.
//

import UIKit



class HomeVC: UIViewController {

    // MARK: - Outlets
    
 
    
    @IBOutlet weak var tblCities: UITableView!
    
    // -----------------------------------------------------------------------------------------------
    
    // MARK: - Class Properties
    
    private var cities: [City] = []
    
    // -----------------------------------------------------------------------------------------------
    
    // MARK: - Memory Management Functions
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        
    }
    
    // -----------------------------------------------------------------------------------------------
    
    // MARK: - Class Functions
    
    private func setupView() {
        
        // Set background image as layer. Becuase of have a large navigation bar
        let backgroundImage = UIImage(named: "background")?.cgImage
        let backgroundLayer = CALayer()
        backgroundLayer.frame = self.view.bounds
        backgroundLayer.contents = backgroundImage
        backgroundLayer.contentsGravity = CALayerContentsGravity.resizeAspectFill
        self.view.layer.insertSublayer(backgroundLayer, at: 0)
        self.view.layer.setNeedsDisplay()
        
        cities = AppDelegate.shared.cities.filter{[4163971, 2147714, 2174003].contains($0.id)}
        setupCityListTableView()
    }
    
    private func setupCityListTableView() {
        tblCities.registerNib(forCellWithClass: HomeCityListCell.self)
        tblCities.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        tblCities.rowHeight = UITableView.automaticDimension
        tblCities.estimatedRowHeight = 64
        tblCities.delegate = self
        tblCities.dataSource = self
    }
    
    // -----------------------------------------------------------------------------------------------
    
    // MARK: - Action Functions
    
    @IBAction func btnAddAction(_ sender: UIBarButtonItem) {
        let vc = UIStoryboard.home.controller(withClass: CityListVC.self)
        vc.alreadyAddedCities = cities
        
        vc.didSelectCity = { city in
            self.cities.insert(city, at: 0)
            self.tblCities.insertRows(at: [IndexPath(row: 0, section: 0)], with: .bottom)
        }
        
        let navController = UINavigationController(rootViewController: vc)
        
        present(navController)
    }
    
    // -----------------------------------------------------------------------------------------------
    
    // MARK: - Web Service Functions
    
    func getWeatherData(cityID: String) {
        
    }
    
    
    
    // -----------------------------------------------------------------------------------------------
    
    // MARK: - Life Cycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // -----------------------------------------------------------------------------------------------

}

// -----------------------------------------------------------------------------------------------

// MARK: - UITableView Delegate & DataSource -

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: HomeCityListCell.self, for: indexPath)
        cell.city = cities[indexPath.row]
        cell.setupTimer(indexPath: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        guard let cityDetail = cities[indexPath.row].weatherSummary else {
            return
        }
        
        let vc = UIStoryboard.home.controller(withClass: WeatherDetailsVC.self)
        vc.cityDetails = cityDetail
        push(vc)
        
    }
    
}

// -----------------------------------------------------------------------------------------------
