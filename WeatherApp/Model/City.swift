//
//  City.swift
//  WeatherApp
//
//  Created by Manish on 10/06/21.
//

import Foundation

class City {
    
    struct Coordinate {
        let latitude    : Double
        let longitude   : Double
        
        init(withJOSN json: JSON) {
            latitude    = json["lat"].doubleValue
            longitude   = json["lon"].doubleValue
        }
    }
    
    struct WeatherSummary {
        let temperature     : Double
        let humidity        : Double
        let tempMin         : Double
        let tempMax         : Double
        let feelsLike       : Double
        
        init(withJOSN json: JSON) {
            temperature     = json["temp"].doubleValue
            humidity        = json["humidity"].doubleValue
            tempMin         = json["temp_min"].doubleValue
            tempMax         = json["temp_max"].doubleValue
            feelsLike       = json["feels_like"].doubleValue
        }
    }
    
    let id              : Int
    let name            : String
    let state           : String
    let country         : String
    let coordinate      : Coordinate
    var weatherSummary  : WeatherSummary?

    init(withJOSN json: JSON) {
        id              = json["id"].intValue
        name            = json["name"].stringValue
        state           = json["state"].stringValue
        country         = json["country"].stringValue
        coordinate      = Coordinate(withJOSN: json["coord"])
    }
}
