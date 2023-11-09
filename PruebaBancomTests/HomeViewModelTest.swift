//
//  HomeViewModelTest.swift
//  PruebaBancomTests
//
//  Created by Jhonatan chavez chavez on 8/11/23.
//

import XCTest
@testable import PruebaBancom

class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var mockService: MockPostService!
    var mockDelegate: MockHomeDelegate!
    var mockCoreDataManager: MockCoreDataManager!
    var mockUserDefaultsLayer: MockUserDefaultsLayer!
    
    override func setUp() {
        super.setUp()
        mockService = MockPostService()
        mockCoreDataManager = MockCoreDataManager()
        mockUserDefaultsLayer = MockUserDefaultsLayer()
        mockDelegate = MockHomeDelegate()
        viewModel = HomeViewModel(service: mockService)
        viewModel.coreDataMananger = mockCoreDataManager
        viewModel.userDefaultsLayer = mockUserDefaultsLayer
        viewModel.delegate = mockDelegate
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        mockDelegate = nil
        mockCoreDataManager = nil
        mockUserDefaultsLayer = nil
        super.tearDown()
    }
    
    func testGetPostWithNoUser() {
        mockUserDefaultsLayer.mockUser = nil
        viewModel.getPost()
        XCTAssertTrue(mockDelegate.errorCalled)
        XCTAssertEqual(mockDelegate.errorMessage, "Usuario no reconocido")
    }
    
    func testGetPostWithUser() {
        mockUserDefaultsLayer.mockUser = User(id: 1, name: "John Doe", username: "johndoe", email: "john@example.com", address: nil, phone: nil, website: nil, company: nil)
        mockService.mockPosts = [Post(userId: 1, id: 1, title: "Test", body: "Test")]
        viewModel.getPost()
        XCTAssertTrue(mockDelegate.postsCalled)
        XCTAssertFalse(mockDelegate.errorCalled)
    }
    
    func testGetProjects() {
        viewModel.getProjects()
        let expect = expectation(description: "Wait for getProjects to return")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // wait longer than the delay in getProjects
            XCTAssertTrue(self.mockDelegate.projectsCalled)
            expect.fulfill()
        }
        waitForExpectations(timeout: 3, handler: nil)
    }
    
}

class MockPostService: PostServiceProtocol {

    var mockPosts: [Post]?
    var mockPost: Post?
    
    func getPosts(id: Int, completion: @escaping ([Post]?) -> Void) {
        completion(mockPosts)
    }
    
    func createPost(request:PostRequest, completion: @escaping (Post?) -> Void) {
        completion(mockPost)
    }
}

class MockHomeDelegate: HomeDelegate {
    var postsCalled = false
    var errorCalled = false
    var projectsCalled = false
    var errorMessage: String?
    
    func getPosts(posts: [Post]) {
        postsCalled = true
    }
    
    func error(error: String) {
        errorCalled = true
        errorMessage = error
    }
    
    func getProjects(projects: [Project]) {
        projectsCalled = true
    }
}

class MockCoreDataManager:CoreDataManagerProtocol {
    func savePost(userId: Int, id: Int, title: String, body: String) {
        
    }
    
    var mockPostsData: [PostsData] = []
    
    func fetchPosts() -> [PostsData] {
        return mockPostsData
    }
}


