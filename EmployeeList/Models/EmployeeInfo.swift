//
//  EmployeeInfo.swift
//  EmployeeList
//
//  Created by Qi Zhan on 7/9/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

import Foundation


enum EmployeeType: String, Decodable {
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
    case contractor = "CONTRACTOR"
}


extension EmployeeType {
    var readableText: String {
        switch self {
        case .fullTime:
            return "Full Time"
        case .partTime:
            return "Part Time"
        case .contractor:
            return "Contractor"
        }
    }
}


struct EmployeeInfo: Decodable {
    
    
    let biography: String?
    let emailAddress: String?
    let employeeType: EmployeeType?
    let fullName: String?
    let largePhotoURL: String?
    let phoneNumber: String?
    let smallPhotoURL: String?
    let team: String?
    let uuid: String?
    
    
    enum CodingKeys: String, CodingKey {
        case uuid = "uuid"
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case biography = "biography"
        case smallPhotoURL = "photo_url_small"
        case largePhotoURL = "photo_url_large"
        case team = "team"
        case employeeType = "employee_type"
    }
    
    
}


extension EmployeeInfo: Equatable {
    
    
    static func ==(lhs: EmployeeInfo, rhs: EmployeeInfo) -> Bool {
        
        return lhs.uuid == rhs.uuid
    }
    
    
}


extension EmployeeInfo: Hashable {
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
    
    
}


extension EmployeeInfo: ModelStateValidatable {
    
    
    var hasMissingValues: Bool {
        
        return self.hasNilField
    }
    
    
    var hasMissingRequiredFields: Bool {
        let requiredFields: [Any?] = [uuid, fullName, emailAddress, team, employeeType]
        if (requiredFields.contains{ $0 == nil }) {
            return true
        }
        
        return false
    }
    
    
}
