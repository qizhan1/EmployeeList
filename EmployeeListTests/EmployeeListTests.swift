//
//  EmployeeListTests.swift
//  EmployeeListTests
//
//  Created by Qi Zhan on 7/9/19.
//  Copyright © 2019 Qi Zhan. All rights reserved.
//

import XCTest
import Mockingjay
@testable import EmployeeList

class EmployeeListTests: XCTestCase {

    override func setUp() {
        // Setup Mockingjay
        guard let employeesListURL = Bundle(for: type(of: self)).url(forResource: "EmployeeList", withExtension: "json") else {
            return
        }
        let employeesResponse = try! Data(contentsOf: employeesListURL)
        stub(http(.get, uri: "https://s3.amazonaws.com/sq-mobile-interview/employees.json"), jsonData(employeesResponse))
    }

    func testEmployeesInfoService() {
        let fetchResponseExpectation = expectation(description: "fetch employees list response")
        
        EmployeeService.getInfo { (employeesData, error) in
            fetchResponseExpectation.fulfill()
            guard let employeeInfo = employeesData?[0] else {
                XCTFail("empolyee info parse error")
                
                return
            }
            XCTAssertEqual(employeeInfo.uuid, "0d8fcc12-4d0c-425c-8355-390b312b909c", "uuid not correct")
            XCTAssertEqual(employeeInfo.fullName, "Justine Mason", "full name not correct")
            XCTAssertEqual(employeeInfo.phoneNumber, "5553280123", "phone number not correct")
            XCTAssertEqual(employeeInfo.emailAddress, "jmason.demo@squareup.com", "email address not correct")
            XCTAssertEqual(employeeInfo.biography, "Engineer on the Point of Sale team.", "biography not correct")
            XCTAssertEqual(employeeInfo.smallPhotoURL, "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/small.jpg", "small photo URL not correct")
            XCTAssertEqual(employeeInfo.largePhotoURL, "https://s3.amazonaws.com/sq-mobile-interview/photos/16c00560-6dd3-4af4-97a6-d4754e7f2394/large.jpg", "large photo URL not correct")
            XCTAssertEqual(employeeInfo.team, "Point of Sale", "team not correct")
            XCTAssertEqual(employeeInfo.employeeType?.rawValue, "FULL_TIME", "type not correct")
            XCTAssertEqual(employeeInfo.biography, "Engineer on the Point of Sale team.", "biography not correct")
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
