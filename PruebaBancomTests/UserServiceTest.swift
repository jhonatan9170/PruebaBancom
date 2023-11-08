//
//  UserServiceTest.swift
//  PruebaBancomTests
//
//  Created by Jhonatan chavez chavez on 8/11/23.
//

import XCTest
@testable import PruebaBancom

final class UserServiceTests: XCTestCase {
    
    var userService: UserService!
    var mockAPIClient: MockAPIClient<UserResponse>!
    
    override func setUp() {
        super.setUp()
        mockAPIClient = MockAPIClient()
        userService = UserService(apiClient: mockAPIClient)
    }
    
    override func tearDown() {
        userService = nil
        mockAPIClient = nil
        super.tearDown()
    }
    
    func testLoginSuccess() {
        let expectation = self.expectation(description: "Login success")
        let mockUserResponse = UserResponse(arrayLiteral: User(id: 1, name: "John Doe", username: "johndoe", email: "johndoe@example.com", address: nil, phone: nil, website: nil, company: nil))
        
        mockAPIClient.nextResult = .success(mockUserResponse)
        
        userService.login(email: "johndoe@example.com", password: "password123") { user in
            XCTAssertNotNil(user, "User should not be nil")
            XCTAssertEqual(user?.email, "johndoe@example.com", "Email should match")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLoginFailure() {
        let expectation = self.expectation(description: "Login failure")
        
        mockAPIClient.nextResult = .failure(.networkError)
        
        userService.login(email: "wrong@example.com", password: "password123") { user in
            XCTAssertNil(user, "User should be nil on login failure")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}


