//
//  BulletinBoardViewModel.swift
//  FureverCat
//
//  Created by xia on 11/11/25.
//

import Foundation
import Combine

class BulletinBoardViewModel: ObservableObject {
    @Published var posts: [Post] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    init() {
        loadMockPosts()
    }
    
    func loadMockPosts() {
        // Mock data for demonstration
        posts = [
            Post(userId: "1", userName: "Sarah Johnson", title: "Found Lost Dog!", content: "Found a golden retriever near Central Park. Very friendly, has a red collar.", imageURL: nil),
            Post(userId: "2", userName: "Mike Chen", title: "Adoption Event This Weekend", content: "Local shelter hosting adoption event Saturday 10am-4pm. Lots of adorable pets looking for homes!", imageURL: nil),
            Post(userId: "3", userName: "Emma Wilson", title: "Best Dog Parks?", content: "New to the area and looking for recommendations for dog-friendly parks. My husky needs lots of space to run!", imageURL: nil),
            Post(userId: "4", userName: "James Brown", title: "Pet Sitting Services", content: "Experienced pet sitter available for weekends and holidays. Great references!", imageURL: nil),
            Post(userId: "5", userName: "Lisa Anderson", title: "Training Tips Needed", content: "My puppy won't stop barking at night. Any training advice? She's 4 months old.", imageURL: nil)
        ]
    }
    
    func addPost(title: String, content: String) {
        let newPost = Post(userId: "current", userName: "You", title: title, content: content)
        posts.insert(newPost, at: 0)
    }
    
    func likePost(postId: String) {
        if let index = posts.firstIndex(where: { $0.id == postId }) {
            posts[index].likes += 1
        }
    }
    
    func deletePost(postId: String) {
        posts.removeAll { $0.id == postId }
    }
}
