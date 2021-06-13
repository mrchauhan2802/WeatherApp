//
//  UITableView + Extensions.swift
//  WeatherApp
//
//  Created by Manish on 10/06/21.
//

import UIKit

// MARK: - Reusable Cell With Class Name -

extension UITableView {
    
    // MARK: - Class Functions

    func dequeueReusableCell<T: UITableViewCell>(withClass name: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: String(describing: name), for: indexPath) as? T else {
            fatalError("Couldn't find UITableViewCell for \(String(describing: name))")
        }
        return cell
    }
    
    func registerNib<T: UITableViewCell>(forCellWithClass name: T.Type) {
        register(UINib.init(nibName: String(describing: name), bundle: nil), forCellReuseIdentifier: String(describing: name))
    }

    // -----------------------------------------------------------------------------------------------
 
}

// -----------------------------------------------------------------------------------------------

