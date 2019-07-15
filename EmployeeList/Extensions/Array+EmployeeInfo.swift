// *************************************************************************************************
// - MARK: Imports


import Foundation


// *************************************************************************************************
// - MARK: Array Extension


extension Array where Element == EmployeeInfo {
    
    
    func removeDuplicatedUUIDs() -> Array<EmployeeInfo> {
        
        return Array(Set(self))
    }
    
    
    func removeMalformedData() -> Array<EmployeeInfo> {
        
        return filter { $0.hasMissingRequiredFields == false }
    }
    
    
    func revised() -> Array<EmployeeInfo> {
        
        return removeDuplicatedUUIDs().removeMalformedData().sortedByTeam()
    }
    
    
    func sortedByTeam() -> Array<EmployeeInfo> {
        
        return sorted { $0.team! < $1.team! }
    }
    
    
}
