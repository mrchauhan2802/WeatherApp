//
//  UIStoryboard + Extensions.swift
//  WeatherApp
//
//  Created by Manish on 10/06/21.
//

import UIKit

// MARK: - Storyboards -

extension UIStoryboard {
    
    // MARK: - Class Properties
    
    private static var bundle: Bundle {
        Bundle.main
    }

    static var home: UIStoryboard {
        UIStoryboard(name: "Home", bundle: bundle)
    }

    // -----------------------------------------------------------------------------------------------
        
    // MARK: - Class Functions
    
    func controller<T: UIViewController>(withClass name: T.Type) -> T {
        instantiateViewController(withIdentifier: String(describing: name)) as? T ?? T()
    }
    
    // -----------------------------------------------------------------------------------------------
}

// -----------------------------------------------------------------------------------------------
