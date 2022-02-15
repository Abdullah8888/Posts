//
//  PostsModel.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 13/01/2022.
//

import Foundation

struct Post: Codable {
    let userID, id: Int?
    let title, body: String?

    enum CodingKeys: String, CodingKey {
        case userID = "userId"
        case id, title, body
    }
}

typealias Posts = [Post]
