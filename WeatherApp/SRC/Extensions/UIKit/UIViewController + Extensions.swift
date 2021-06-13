//
//  UIViewController + Extensions.swift
//  WeatherApp
//
//  Created by Manish on 10/06/21.
//

import UIKit

extension UIViewController {
    
    // MARK: - Class Functions
    
    func push(_ receiver: UIViewController, _ animated: Bool = true, hidesBottomBarWhenPushed: Bool = false) {
        receiver.hidesBottomBarWhenPushed = hidesBottomBarWhenPushed
        navigationController?.pushViewController(receiver, animated: animated)
    }
    
    func present(_ vc: UIViewController, _ animated: Bool = true) {
        view.endEditing(true)
        present(vc, animated: animated, completion: nil)
    }
    
    func popVC(_ animated: Bool = true) {
        navigationController?.popViewController(animated: animated)
    }
    
    func popToRootVC(_ animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }
    
    // -----------------------------------------------------------------------------------------------
    
    // MARK: - Action Functions
    
    @IBAction func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    // -----------------------------------------------------------------------------------------------

}
