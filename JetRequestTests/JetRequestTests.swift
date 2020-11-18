//
//  JetRequestTests.swift
//  JetRequestTests
//
//  Created by Yousef on 9/25/20.
//  Copyright © 2020 Yousef. All rights reserved.
//

import XCTest
@testable import JetRequest

class JetRequestTests: XCTestCase {

    let token = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbkV4cGlyZURhdGUiOjE2MDE2MzI3MDEuMjk0NTksInVzZXJJZCI6MSwidG9rZW4iOiIiLCJ0b2tlbkNyZWF0aW9uRGF0ZSI6MTYwMTAyNzkwMS4yOTQ1OX0.P9vu24lepXo_X-kiRKbt3U-kaP6tz7fdhjAg1FSe1gc"
    
    override func setUp() {
        JetRequest.initSession(baseURL: "http://mydesignerapp.com/api/")
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testGet() {
        let expectation = self.expectation(description: "API Response")
//
//        let headers = ["Authorization": token]
        JetRequest.request(path: "settings", httpMethod: .get).fire { (res: Result<[String : Any?]?, JetError>) in
            switch res {
            
            case .success(let dict):
                print(dict)
                expectation.fulfill()
            case .failure(let err):
                print(err)
                XCTFail("Filaure")
            }
        }
//
        waitForExpectations(timeout: 15)
    }
    
    func testPost() {
//        let expectation = self.expectation(description: "API Response")
//        let params = ["email": "test@test.com", "password": "123456"]
        JetRequest.request(path: "complaint", httpMethod: .post)
//        
//        waitForExpectations(timeout: 15)
    }
    
    func testDownload() {}
    
    func testUpload() {}
    
    
    struct Contact: Decodable {
        let id: Int
        let phoneNumbers: [String]
        let name: String
        let emails: [String]
    }

}
