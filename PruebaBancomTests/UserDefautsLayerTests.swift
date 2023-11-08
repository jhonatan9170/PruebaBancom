//
//  UserDefautsLayerTests.swift
//  PruebaBancomTests
//
//  Created by Jhonatan chavez chavez on 8/11/23.
//

import XCTest
@testable import PruebaBancom
final class UserDefaultsLayerTests: XCTestCase {
    var userDefaultsLayer: UserDefaultsLayer!
    var mockUserDefaults: MockUserDefaults!
    
    override func setUp() {
        super.setUp()
        mockUserDefaults = MockUserDefaults()
        userDefaultsLayer = UserDefaultsLayer(defaults: mockUserDefaults)
    }
    
    override func tearDown() {
        userDefaultsLayer = nil
        mockUserDefaults = nil
        super.tearDown()
    }
    
    func testSaveUser() {
        let user = User(id: 1, name: "John Doe", username: "johndoe", email: "john@example.com", address: nil, phone: nil, website: nil, company: nil)
        userDefaultsLayer.saveUser(value: user)
        
        XCTAssertNotNil(mockUserDefaults.store[Constants.userKey])
    }
    
    func testGetUser() {
        // First, save a user
        let user = User(id: 1, name: "John Doe", username: "johndoe", email: "john@example.com", address: nil, phone: nil, website: nil, company: nil)
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(user) {
            mockUserDefaults.set(encoded, forKey: Constants.userKey)
        }
        
        // Now, retrieve the user
        if let retrievedUser = userDefaultsLayer.getUser() {
            XCTAssertEqual(retrievedUser.id, user.id)
            XCTAssertEqual(retrievedUser.name, user.name)
            XCTAssertEqual(retrievedUser.username, user.username)
            XCTAssertEqual(retrievedUser.email, user.email)
        } else {
            XCTFail("User should be retrievable")
        }
    }
    
    func testSaveValue() {
        userDefaultsLayer.save(value: "TestValue", forKey: "TestKey")
        XCTAssertEqual(mockUserDefaults.store["TestKey"] as? String, "TestValue")
    }
    
    func testGetValue() {
        mockUserDefaults.set("TestValue", forKey: "TestKey")
        XCTAssertEqual(userDefaultsLayer.getValue(forKey: "TestKey") as? String, "TestValue")
    }
}

class MockUserDefaults: UserDefaultsProtocol {
    var store = [String: Any]()
    
    func set(_ value: Any?, forKey defaultName: String) {
        store[defaultName] = value
    }
    
    func value(forKey defaultName: String) -> Any? {
        return store[defaultName]
    }
}
