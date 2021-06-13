//
//  HomeCityListCell.swift
//  WeatherApp
//
//  Created by Manish on 10/06/21.
//

import UIKit

class HomeCityListCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    
    var cityData: City!
    
    // -----------------------------------------------------------------------------------------------
    
    // MARK: - Class Properties
    
    var city: City! {
        didSet {
            lblCityName.text = city.name
            
            let temperature = city.weatherSummary?.temperature ?? 0
            
            lblTemperature.text = (temperature > 0) ? "\(temperature)" : ""
        }
    }
    
    var dataUpdateTimer: Timer?
    
    private var currentIndex: Int = 1
    
    // -----------------------------------------------------------------------------------------------
    
    // MARK: - Class Functions
    
    func setupTimer(indexPath: Int) {
        currentIndex = indexPath + 1
        
        stopTimer()
        
        dataUpdateTimer = Timer.scheduledTimer(timeInterval: 15.0, target: self, selector: #selector(self.calculateTime), userInfo: nil, repeats: true);
        
        RunLoop.current.add(dataUpdateTimer!, forMode: .common)
        dataUpdateTimer?.fire()
    }
    
    func stopTimer() {
        if dataUpdateTimer != nil {
            dataUpdateTimer?.invalidate()
            dataUpdateTimer = nil
        }
    }
    
    @objc private func calculateTime() {
        updateTemperature()
    }
    
    // -----------------------------------------------------------------------------------------------
    
    // MARK: - Web Service Functions
    
    private func updateTemperature() {
        let url = "https://api.openweathermap.org/data/2.5/weather?id=\(city.id)&units=metric&&APPID=\(AppDelegate.shared.weatherAPIKey)"
        NetworkManager.shared.request(url: url, methodType: .get, withLoader: false) { (response, error, status) in
            if status == .successResponse, let response = response {
                let jsonData = JSON(response)
                self.city.weatherSummary = City.WeatherSummary(withJOSN: jsonData["main"])
                
                let temperature = self.city.weatherSummary?.temperature ?? 0
                
                self.lblTemperature.text = (temperature > 0) ? "\(temperature)" : ""
            }
        }
    }
    
    // -----------------------------------------------------------------------------------------------
    
    // MARK: - Life Cycle Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // -----------------------------------------------------------------------------------------------
}
