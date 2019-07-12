//
//  ModelStateValidatable.swift
//  EmployeeList
//
//  Created by Qi Zhan on 7/11/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

import Foundation


protocol ModelStateValidatable {
    
    var hasMissingRequiredFields: Bool { get }
    var hasNilField: Bool { get }
    
    
}


extension ModelStateValidatable {
    
    
    var hasNilField: Bool {
        let hasNilField = Mirror(reflecting: self).children.contains(where: {
            if case Optional<Any>.some(_) = $0.value {
                return false
            } else {
                return true
            }
        })
        
        return hasNilField
    }
    
    
}
