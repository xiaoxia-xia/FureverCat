//
//  Post.swift
//  FureverCat
//
//  Created by xia on 11/11/25.
//

import Foundation

struct Post: Identifiable, Codable {
    let id: String
    var userId: String
    var userName: String
    var title: String
    var content: String
    var imageURL: String?
    var createdAt: Date
    var likes: Int
    var comments: Int
    
    init(id: String = UUID().uuidString, userId: String, userName: String, title: String, content: String, imageURL: String? = nil) {
        self.id = id
        self.userId = userId
        self.userName = userName
        self.title = title
        self.content = content
        self.imageURL = imageURL
        self.createdAt = Date()
        self.likes = 0
        self.comments = 0
    }
}
