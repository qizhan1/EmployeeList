//
//  NSShadow+Extensions.swift
//  EmployeeList
//
//  Created by Qi Zhan on 7/9/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

import Foundation
import UIKit

extension NSShadow {
    
    static var titleTextShadow: NSShadow {
        let shadow: NSShadow = NSShadow()
        
        shadow.shadowColor = UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 0.3)
        shadow.shadowOffset = CGSize(width: 0, height: 2)
        shadow.shadowBlurRadius = 3.0
        
        return shadow
    }
    
    
    static var descriptionTextShadow: NSShadow {
        let shadow: NSShadow = NSShadow()
        
        shadow.shadowColor = UIColor(white: 0, alpha: 0.3)
        shadow.shadowOffset = CGSize(width: 0, height: 1)
        shadow.shadowBlurRadius = 3.0
        
        return shadow
    }
    
    
}
