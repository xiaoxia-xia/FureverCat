//
//  User.swift
//  FureverCat
//
//  Created by xia on 11/11/25.
//

import Foundation

struct User: Identifiable, Codable {
    let id: String
    var email: String
    var name: String
    var profileImageURL: String?
    var createdAt: Date
    
    init(id: String = UUID().uuidString, email: String, name: String, profileImageURL: String? = nil) {
        self.id = id
        self.email = email
        self.name = name
        self.profileImageURL = profileImageURL
        self.createdAt = Date()
    }
}
