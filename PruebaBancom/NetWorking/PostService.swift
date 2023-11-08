//
//  PostService.swift
//  PruebaBancom
//
//  Created by Jhonatan chavez chavez on 8/11/23.
//

import Foundation

protocol PostServiceProtocol {
    func getPosts(id: Int, completion: @escaping ([Post]?) -> Void)
    func createPost(request: PostRequest, completion: @escaping (Post?) -> Void)
}

class PostService: PostServiceProtocol {
    
    var apiClient: APIClient
    
    init(apiClient: APIClient = .shared) {
        self.apiClient = apiClient
    }
    
    func getPosts (id:Int, completion: @escaping ([Post]?) -> Void ) {
        
        let url = Constants.getUsersURL + "/\(id)/posts"
        apiClient.request(url: url, method: .get) { (result : Result<PostResponse, APIClientError>) in
            switch result {
            case .success(let posts) :
                completion(posts)
            case .failure(let error):
                completion(nil)
            }
        }
        
    }
    
    func createPost (request: PostRequest, completion: @escaping (Post?) -> Void ) {
        
        apiClient.request(url: Constants.createPostsURL, method: .post,parameters: request.dictionary) { (result : Result<Post, APIClientError>) in
            switch result {
            case .success(let post) :
                completion(post)
            case .failure(let error):
                completion(nil)
            }
        }
        
    }
}
    
