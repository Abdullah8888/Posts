//
//  UsersModel.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 13/01/2022.
//

import Foundation

struct User: Codable {
    let id: Int?
    let avatar: Avatar?
    let username: String?
}

struct Avatar: Codable {
    let large, medium, thumbnail: String?
}

typealias Users = [User]
