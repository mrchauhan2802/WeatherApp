//
//  CityListCell.swift
//  WeatherApp
//
//  Created by Manish on 10/06/21.
//

import UIKit

class CityListCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    
    // -----------------------------------------------------------------------------------------------
    
    // MARK: - Class Properties
    
    var city: City! {
        didSet {
            lblCityName.text = city.name
            lblCountry.text = city.country
        }
    }
    
    // -----------------------------------------------------------------------------------------------
    
    // MARK: - Class Functions
    
    
    
    // -----------------------------------------------------------------------------------------------
    
    // MARK: - Life Cycle Functions
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // -----------------------------------------------------------------------------------------------
    
}
