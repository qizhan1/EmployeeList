// *************************************************************************************************
// - MARK: Imports


import Foundation


// *************************************************************************************************
// - MARK: EmployeeService


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
