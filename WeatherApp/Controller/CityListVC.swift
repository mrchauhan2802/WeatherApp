//
//  CityListVC.swift
//  WeatherApp
//
//  Created by Manish on 10/06/21.
//

import UIKit

class CityListVC: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var tblCities: UITableView!
    
    @IBOutlet weak var txtSearch: UITextField!
    
    // -----------------------------------------------------------------------------------------------
    
    // MARK: - Class Properties
    
    var didSelectCity: ((City) -> ())?
    
    private var cities: [City] = [] {
        didSet {
            filteredCities = cities
        }
    }
    
    private var filteredCities: [City] = []
    
    var alreadyAddedCities: [City] = []
    
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
        txtSearch.addTarget(self, action: #selector(searchTextFieldTextChanged(_:)), for: .editingChanged)
        cities = AppDelegate.shared.cities.filter {!alreadyAddedCities.map{$0.id}.contains($0.id)}
        setupCityListTableView()
    }
    
    @objc private func searchTextFieldTextChanged(_ textField: UITextField) {
        if textField.text!.isEmpty {
            filteredCities = cities
        } else {
            filteredCities = cities.filter{$0.name.lowercased().contains(textField.text!.lowercased())}
        }
        
        tblCities.reloadData()
    }
    
    private func setupCityListTableView() {
        tblCities.registerNib(forCellWithClass: CityListCell.self)
        tblCities.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 8, right: 0)
        tblCities.rowHeight = UITableView.automaticDimension
        tblCities.estimatedRowHeight = 64
        tblCities.delegate = self
        tblCities.dataSource = self
    }
    
    // -----------------------------------------------------------------------------------------------
    
    // MARK: - Action Functions
    
   
    
    // -----------------------------------------------------------------------------------------------
    
    // MARK: - Web Service Functions
    
    
    
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

extension CityListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withClass: CityListCell.self, for: indexPath)
        cell.city = filteredCities[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectCity?(filteredCities[indexPath.row])
        dismiss()
    }
    
}

// -----------------------------------------------------------------------------------------------
