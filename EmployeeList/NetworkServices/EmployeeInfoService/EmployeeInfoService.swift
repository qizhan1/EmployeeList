//
//  EmployeInfoService.swift
//  EmployeeList
//
//  Created by Qi Zhan on 7/9/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

import Foundation


class EmployeeService: NetworkResponseValidatable {
    
    
    public static func getInfo(completion: @escaping (_ movie: [EmployeeInfo]?, _ error: String?) -> Void) {
        Router<EmployeeInfoEndpoint>().request(.normal) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = EmployeeService.validateNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        
                        return
                    }
                    do {
//                        print(responseData)
//                        let jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
//                        print(jsonData)
                        let apiResponse = try JSONDecoder().decode(EmployeeInfoResponse.self, from: responseData)
                        completion(apiResponse.employees,nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    
}
