//
//  CardView.swift
//  WeatherApp
//
//  Created by Manish on 10/06/21.
//

import UIKit

// MARK: - Card View -

class CardView: UIView {
    
    // MARK: - Class Properties
    
    @IBInspectable var shadowColor: UIColor = UIColor.gray.withAlphaComponent(0.6)
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 5)
    @IBInspectable var shadowRadius: CGFloat = 8
    @IBInspectable var shadowOpacity: Float = 0.6
    
    // -----------------------------------------------------------------------------------------------
    
    // MARK: - Life Cycle Functions

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 12
    }
    
    override func layoutSubviews() {
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
        layer.shadowOpacity = shadowOpacity
    }
    
    // -----------------------------------------------------------------------------------------------
}

// -----------------------------------------------------------------------------------------------
