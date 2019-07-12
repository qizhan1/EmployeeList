//
//  EmployeeInfoDataStore.swift
//  EmployeeList
//
//  Created by Qi Zhan on 7/10/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

import Foundation

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
