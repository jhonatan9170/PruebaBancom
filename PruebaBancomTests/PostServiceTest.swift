//
//  PostServiceTest.swift
//  PruebaBancomTests
//
//  Created by Jhonatan chavez chavez on 8/11/23.
//

import XCTest
@testable import PruebaBancom


final class PostServiceTests: XCTestCase {
    
    var postService: PostService!
    var mockAPIClient: MockAPIClient<PostResponse>!
    
    override func setUp() {
        super.setUp()
        mockAPIClient = MockAPIClient()
        postService = PostService(apiClient: mockAPIClient)
    }
    
    override func tearDown() {
        postService = nil
        mockAPIClient = nil
        super.tearDown()
    }
    
    func testGetPostsSuccess() {
        let expectation = self.expectation(description: "getPosts success")
        
        let mockPosts: PostResponse = [Post(userId: 1, id: 1, title: "Test Post", body: "This is a test post")]
        mockAPIClient.nextResult = .success(mockPosts)
        
        postService.getPosts(id: 1) { posts in
            XCTAssertNotNil(posts, "Posts should not be nil")
            XCTAssertEqual(posts?.count, 1, "There should be one post")
            XCTAssertEqual(posts?.first?.title, "Test Post", "The post title should be 'Test Post'")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    func testGetPostsFailure() {
        let expectation = self.expectation(description: "getPosts failure")
        
        mockAPIClient.nextResult = .failure(.networkError)
        
        postService.getPosts(id: 1) { posts in
            XCTAssertNil(posts, "Posts should be nil on failure")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testCreatePostSuccess() {
        let expectation = self.expectation(description: "createPost success")
    
        var mockAPIClient: MockAPIClient<Post>! = MockAPIClient()
        postService = PostService(apiClient: mockAPIClient)
        
        let request = PostRequest(title: "New Post", body: "Content of the new post", userId: 1)
        let mockPost = Post(userId: request.userId, id: 1, title: request.title, body: request.body)
        mockAPIClient.nextResult = .success(mockPost)
        
        postService.createPost(request: request) { post in
            XCTAssertNotNil(post, "Post should not be nil")
            XCTAssertEqual(post?.title, request.title, "Post title should match the request")
            XCTAssertEqual(post?.body, request.body, "Post body should match the request")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testCreatePostFailure() {
        let expectation = self.expectation(description: "createPost failure")
    
        var mockAPIClient: MockAPIClient<Post>! = MockAPIClient()
        postService = PostService(apiClient: mockAPIClient)
        
        let request = PostRequest(title: "New Post", body: "Content of the new post", userId: 1)
        mockAPIClient.nextResult = .failure(.networkError)
        
        postService.createPost(request: request) { post in
            XCTAssertNil(post, "Post should be nil on failure")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1, handler: nil)
    }
}


