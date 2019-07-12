//
//  UIFont+Extensions.swift
//  EmployeeList
//
//  Created by Qi Zhan on 7/9/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

import Foundation
import UIKit


extension UIFont {
    
    
    static var titleFont: UIFont {
        guard let font = UIFont(name: "AvenirNext-Heavy", size: 30) else {
            
            return UIFont.systemFont(ofSize: 30)
        }
        
        return font
    }
    
    
    static var descriptionFont: UIFont {
        guard let font = UIFont(name: "AvenirNext-Medium", size: 16) else {
            
            return UIFont.systemFont(ofSize: 30)
        }
        
        return font
    }
    
    
}
