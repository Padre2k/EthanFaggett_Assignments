//
//  Utilities.swift
//  SalesByMatch_EFaggett
//
//  Created by Ethan Faggett on 3/21/22.
//

import Foundation
import UIKit

class Utilities {
    
    static func styleHollowButtonFaded(_ button:UIButton) {
        
        // Hollow rounded corner style
        button.backgroundColor = UIColor.init(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.25)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
        button.titleLabel?.textColor = .white
    }
    
}
