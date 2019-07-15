// *************************************************************************************************
// - MARK: Imports


import Foundation


// *************************************************************************************************
// - MARK: EmployeeDataProvider


class  EmployeeDataProvider {
    
    
    static let shared = EmployeeDataProvider()
    
    
    var originalEmployeesData: [EmployeeInfo]?
    
    
    public func getInfo(completion: @escaping (_ employees: [EmployeeInfo]?, _ error: String?) -> Void) {
        EmployeeService.getInfo { [weak self] (employeesData, error) in
            self?.originalEmployeesData = employeesData
            // Removed duplicated UUID
            // Removed malformed data
            // Sorted by team name
            let revisedEmployeesData = employeesData?.revised()
            
            completion(revisedEmployeesData, error)
            
        }
    }
    
    
}
