//
//  CreatePostViewModel.swift
//  PruebaBancomTests
//
//  Created by Jhonatan chavez chavez on 8/11/23.
//
import XCTest
@testable import PruebaBancom

class CreatePostViewModelTests: XCTestCase {
    
    var viewModel: CreatePostViewModel!
    var mockService: MockPostService!
    var mockDelegate: MockCreatePostDelegate!
    var mockCoreDataManager: MockCoreDataManager!
    var mockUserDefaultsLayer: MockUserDefaultsLayer!
    
    override func setUp() {
        super.setUp()
        mockService = MockPostService()
        mockCoreDataManager = MockCoreDataManager()
        mockUserDefaultsLayer = MockUserDefaultsLayer()
        mockDelegate = MockCreatePostDelegate()
        
        viewModel = CreatePostViewModel(service: mockService)
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
    
    func testCreatePostWithNoUser() {
        mockUserDefaultsLayer.mockUser = nil
        viewModel.createPost()
        XCTAssertTrue(mockDelegate.createPostErrorCalled)
        XCTAssertEqual(mockDelegate.createPostErrorMessage, "Usuario no reconocido")
    }
    
    func testCreatePostWithUserSuccess() {
        let testUser = User(id: 1, name: "John Doe", username: "johndoe", email: "john@example.com", address: nil, phone: nil, website: nil, company: nil)
        mockUserDefaultsLayer.mockUser = testUser
        let post = Post(userId: testUser.id, id: 1, title: "Test Title", body: "Test Body")
        mockService.mockPost = post
        viewModel.title = "Test Title"
        viewModel.body = "Test Body"
        viewModel.createPost()
        XCTAssertTrue(mockDelegate.createPostCalled)
        XCTAssertNotNil(mockDelegate.createdPost)
        XCTAssertEqual(mockDelegate.createdPost?.title, "Test Title")
        XCTAssertEqual(mockDelegate.createdPost?.body, "Test Body")
    }
}



class MockCreatePostDelegate: CreatePostDelegate {
    var createPostCalled = false
    var createPostErrorCalled = false
    var createdPost: Post?
    var createPostErrorMessage: String?
    
    func createPost(post: Post) {
        createPostCalled = true
        createdPost = post
    }
    
    func createPost(error: String) {
        createPostErrorCalled = true
        createPostErrorMessage = error
    }
}
