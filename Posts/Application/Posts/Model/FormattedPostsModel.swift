//
//  FormattedPostsModel.swift
//  LeagueMobileChallenge
//
//  Created by Abdullah on 13/01/2022.
//

import Foundation
import RealmSwift

struct FormattedPosts: Codable {
    let userId: Int?
    let avatar: String?
    let username: String?
    let title: String?
    let description: String?
}

class UserWithPost: Object {
    @Persisted var userId: Int?
    @Persisted var avatar: String?
    @Persisted var username: String?
    @Persisted var title: String?
    @Persisted var body: String?
}
