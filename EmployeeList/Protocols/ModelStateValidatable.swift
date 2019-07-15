// *************************************************************************************************
// - MARK: Imports


import Foundation


// *************************************************************************************************
// - MARK: protocol


protocol ModelStateValidatable {
    
    var hasMissingRequiredFields: Bool { get }
    var hasNilField: Bool { get }
    
    
}


// *************************************************************************************************
// - MARK: ModelStateValidatable


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
