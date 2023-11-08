//
//  Post.swift
//  PruebaBancom
//
//  Created by Jhonatan chavez chavez on 8/11/23.
//

import Foundation

typealias PostResponse = [Post]

struct Post: Codable {
    let userId, id: Int
    let title, body: String
}

struct PostRequest:Codable {
    let title, body: String
    let userId: Int
}
