//
//  APIClient.swift
//  PruebaBancom
//
//  Created by Jhonatan chavez chavez on 8/11/23.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}


enum APIClientError: Error {
    case badURL
    case networkError
    case decodingError(Error)
}

class APIClient {
    
    static let shared = APIClient()
    
    var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Codable>(url:String, method: HTTPMethod, parameters: [String: Any]? = nil, completion: @escaping (Result<T,APIClientError>) -> Void) {
        
        
        guard let url = URL(string: url) else {
            completion(.failure(.badURL))
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        
        if let parameters = parameters {
            if method == .post {
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                } catch {
                    completion(.failure(.decodingError(error)))
                    return
                }
            }
        }
        
        let task = session.dataTask(with: request) { (data, response, error) in

            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(.decodingError(error)))
                }
            } else {
                completion(.failure(.networkError))
            }
        }
        task.resume()
    }
}

