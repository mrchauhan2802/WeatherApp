//
//  UILabel+Extension.swift
//  WeatherApp
//
//  Created by Manish Chauhan on 12/6/21.
//

import UIKit

class SmallBoldLable: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.font = .boldSystemFont(ofSize: 16)
        self.textColor = .black
    }
}

class SmallRegularLable: UILabel {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.font = .systemFont(ofSize: 13)
        self.textColor = .gray
    }
}
