//
//  FollowerModel.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 21.01.2024.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
    }
}
