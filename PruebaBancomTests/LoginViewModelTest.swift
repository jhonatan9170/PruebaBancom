//
//  LoginViewModelTest.swift
//  PruebaBancomTests
//
//  Created by Jhonatan chavez chavez on 8/11/23.
//

import XCTest
@testable import PruebaBancom

import XCTest

class LoginViewModelTests: XCTestCase {
    
    var viewModel: LoginViewModel!
    var mockUserService: MockUserService!
    var mockDelegate: MockLoginDelegate!
    var mockUserDefaultsLayer: MockUserDefaultsLayer!
    
    override func setUp() {
        super.setUp()
        mockUserService = MockUserService()
        mockUserDefaultsLayer = MockUserDefaultsLayer()
        mockDelegate = MockLoginDelegate()
        viewModel = LoginViewModel(service: mockUserService)
        viewModel.delegate = mockDelegate
        viewModel.userDefaultsLayer = mockUserDefaultsLayer
    }
    
    override func tearDown() {
        viewModel = nil
        mockUserService = nil
        mockDelegate = nil
        mockUserDefaultsLayer = nil
        super.tearDown()
    }
    
    func testLoginSuccess() {
        let user = User(id: 1, name: "John Doe", username: "johndoe", email: "test@example.com", address: nil, phone: nil, website: nil, company: nil)
        mockUserService.mockUser = user
        viewModel.email = "test@example.com"
        viewModel.password = "password123"
        
        viewModel.login()
        
        XCTAssertTrue(mockDelegate.loginSuccess, "The login(user:) delegate method should be called on successful login.")
    }
    
    func testLoginWithInvalidEmail() {
        viewModel.email = "invalidEmail"
        viewModel.password = "password1234"
        
        viewModel.login()
        
        XCTAssertTrue(mockDelegate.loginFailure, "The login(error:) delegate method should be called on invalid email.")
        XCTAssertEqual(mockDelegate.errorMessage, "Correo inválido", "The login error message should match the expected error for invalid email.")
    }
    
    func testLoginWithShortPassword() {
        viewModel.email = "test@example.com"
        viewModel.password = "short"
        
        viewModel.login()
        
        XCTAssertTrue(mockDelegate.loginFailure, "The login(error:) delegate method should be called on short password.")
        XCTAssertEqual(mockDelegate.errorMessage, "Contraseña debe tener minimo 8 caracteres", "The login error message should match the expected error for short password.")
    }
    
    func testLoginWithIncorrectCredentials() {
        mockUserService.mockUser = nil
        viewModel.email = "user@example.com"
        viewModel.password = "password1234"
        
        viewModel.login()
        
        XCTAssertTrue(mockDelegate.loginFailure, "The login(error:) delegate method should be called on incorrect credentials.")
        XCTAssertEqual(mockDelegate.errorMessage, "Credenciales incorrectas", "The login error message should match the expected error for incorrect credentials.")
        
    }
}

class MockUserService: UserServiceProtocol {
    var mockUser: User?
    var error: APIClientError?
    
    func login(email: String, password: String, completion: @escaping (User?) -> Void) {
        if let error = error {
            completion(nil)
        } else {
            completion(mockUser)
        }
    }
}
class MockLoginDelegate: LoginProtocol {
    
    var loginSuccess = false
    var loginFailure = false
    var loggedInUser: User?
    var errorMessage: String?
    
    func login(user: User) {
        loginSuccess = true
        loggedInUser = user
    }
    
    func login(error: String) {
        loginFailure = true
        errorMessage = error
    }
}

class MockUserDefaultsLayer: UserDefaultsLayer {
    var userDefaultsDictionary = [String: Any]()
    var mockUser: User? // Add this property to store a mock User object
    
    override func getUser() -> User? {
        return mockUser
    }
    override func save(value: Any?, forKey key: String) {
        userDefaultsDictionary[key] = value
    }
    
    override func saveUser(value: User) {
    }
    
    override func getValue(forKey key: String) -> Any? {
        return userDefaultsDictionary[key]
    }
}
