//
//  UserService.swift
//  PruebaBancom
//
//  Created by Jhonatan chavez chavez on 8/11/23.
//

import Foundation

protocol UserServiceProtocol {
    func login(email: String, password: String, completion: @escaping (User?) -> Void)
}

class UserService:UserServiceProtocol {

    var apiClient: APIClient
    
    init(apiClient: APIClient = .shared) {
        self.apiClient = apiClient
    }
    
    func login (email: String, password: String , completion: @escaping (User?) -> Void ) {
        
        apiClient.request(url: Constants.getUsersURL, method: .get) { (result : Result<UserResponse, APIClientError>) in
            switch result {
            case .success(let users) :
                guard let user = users.first(where: {$0.email == email}) else {
                    completion(nil)
                    return
                }
                completion(user)
            case .failure(_):
                completion(nil)
            }
        }

    }
}

