//
//  Constant.swift
//  TechAssessment
//
//  Created by ITCAN  on 16/04/24.
//

import Foundation
import UIKit

let apiURL = "https://api.unsplash.com/photos/random?count=100&client_id=\(APIKey)"

let APIKey = "2DbdATMomI1UL4xb8_sHjaabOZE7v4Cj4VXDj_Lct1U"


extension UIView {
    
    func setCorner() {
        self.layer.shadowRadius = 5
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: -2, height: 2)
        self.layer.shadowOpacity = 0.5
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.yellow.cgColor
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
    }
}
