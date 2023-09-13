//
//  User.swift
//  EveryRepTest
//
//  Created by Chris Schmidt on 9/12/23.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    var username: String
    var profileImageUrl: String?
    var fullname: String?
    var bio: String?
    let email: String
    
    
}

extension User {
    static var MOCK_USERS: [User] = [
        .init(id: NSUUID().uuidString, username: "Chris", profileImageUrl: "Logo", fullname: "Chris Schmidt", bio: "Hero", email: "ChrisSchmidt@gmail.com"),
        .init(id: NSUUID().uuidString, username: "Lance", profileImageUrl: "Logo1", fullname: "Lance Machado", bio: "Hero", email: "lanceMachado@gmail.com"),
        .init(id: NSUUID().uuidString, username: "Tara", profileImageUrl: "Logo_Orange", fullname: "Tara Bradley", bio: "Hero", email: "TaraBradley@gmail.com"),
    ]
}
