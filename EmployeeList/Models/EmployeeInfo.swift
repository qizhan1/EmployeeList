//
//  EmployeeInfo.swift
//  EmployeeList
//
//  Created by Qi Zhan on 7/9/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

import Foundation


enum EmployeeType: String {
    case fullTime = "FULL_TIME"
    case partTime = "PART_TIME"
    case contractor = "CONTRACTOR"
    case unknown = "UNKNOWN"
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
        case .unknown:
            return "Unknown"
        }
    }
}


struct EmployeeInfo {
    
    
    let biography: String?
    let emailAddress: String?
    let employeeType: EmployeeType?
    let fullName: String?
    let largePhotoURL: String?
    let phoneNumber: String?
    let smallPhotoURL: String?
    let team: String?
    let uuid: String?
    
    
}



extension EmployeeInfo: Codable {
    
    
    // - MARK: CodingKeys
    
    
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
    
    
    // - MARK: Codable
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        uuid = try? values.decode(String.self, forKey: .uuid)
        fullName = try? values.decode(String.self, forKey: .fullName)
        phoneNumber = try? values.decode(String.self, forKey: .phoneNumber)
        emailAddress = try? values.decode(String.self, forKey: .emailAddress)
        biography = try? values.decode(String.self, forKey: .biography)
        smallPhotoURL = try? values.decode(String.self, forKey: .smallPhotoURL)
        largePhotoURL = try? values.decode(String.self, forKey: .largePhotoURL)
        team = try? values.decode(String.self, forKey: .team)
        if let employeeTypeStr = try? values.decode(String.self, forKey: .employeeType) {
            employeeType = EmployeeType(rawValue: employeeTypeStr)
        } else {
            employeeType = .unknown
        }
    }
    
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(uuid, forKey: .uuid)
        try container.encode(fullName, forKey: .fullName)
        try container.encode(phoneNumber, forKey: .phoneNumber)
        try container.encode(emailAddress, forKey: .emailAddress)
        try container.encode(biography, forKey: .biography)
        try container.encode(smallPhotoURL, forKey: .smallPhotoURL)
        try container.encode(largePhotoURL, forKey: .largePhotoURL)
        try container.encode(team, forKey: .team)
        if let employeeTypeStr = employeeType?.rawValue {
            try container.encode(employeeTypeStr, forKey: .employeeType)
        }
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
