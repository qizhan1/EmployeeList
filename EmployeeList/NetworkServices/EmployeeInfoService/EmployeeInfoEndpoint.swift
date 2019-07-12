//
//  EmployeeInfoEndpoint.swift
//  EmployeeList
//
//  Created by Qi Zhan on 7/9/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

import Foundation


public enum EmployeeInfoEndpoint {
    case normal
    case malformed
    case empty
}


extension EmployeeInfoEndpoint: URLRequestConvertiable {
    
    
    var baseURL: URL {
        guard let url = URL(string: "https://s3.amazonaws.com/sq-mobile-interview") else { fatalError("baseURL could not be configured.") }
        
        return url
    }
    
    var path: String {
        switch self {
        case .normal:
            return "employees.json"
        case .malformed:
            return "employees_malformed.json"
        case .empty:
            return "employees_empty.json"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    
    var task: HTTPTask {
        return .request
    }
    
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
