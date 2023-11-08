//
//  APIClientMock.swift
//  PruebaBancomTests
//
//  Created by Jhonatan chavez chavez on 8/11/23.
//

import Foundation
@testable import PruebaBancom

class MockAPIClient<T>: APIClient {
    var nextResult: Result<T, APIClientError>?
    
    override func request<T>(url: String, method: HTTPMethod, parameters: [String : Any]? = nil, completion: @escaping (Result<T, APIClientError>) -> Void) {
        if let nextResult = nextResult as? Result<T, APIClientError> {
            completion(nextResult)
        }
    }
}
