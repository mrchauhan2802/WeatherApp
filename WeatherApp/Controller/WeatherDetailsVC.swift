//
//  WeatherDetailsVC.swift
//  WeatherApp
//
//  Created by Manish Chauhan on 12/6/21.
//

import UIKit

class WeatherDetailsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblweatherSummary: UITableView!
    
    var cityDetails: City.WeatherSummary!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tblweatherSummary.tableFooterView = UIView()
        
    }
    


    // MARK: - TableView Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Temprature"
            cell.detailTextLabel?.text = "\(cityDetails.temperature)"
        case 1:
            cell.textLabel?.text = "Temprature Minimum"
            cell.detailTextLabel?.text = "\(cityDetails.tempMin)"
        case 2:
            cell.textLabel?.text = "Temprature Maximum"
            cell.detailTextLabel?.text = "\(cityDetails.tempMax)"
        case 3:
            cell.textLabel?.text = "Humidity"
            cell.detailTextLabel?.text = "\(cityDetails.humidity)"
        
        default:
            cell.textLabel?.text = "Feels Like"
            cell.detailTextLabel?.text = "\(cityDetails.feelsLike)"
        }
        
        return cell
    }
    
   
}
