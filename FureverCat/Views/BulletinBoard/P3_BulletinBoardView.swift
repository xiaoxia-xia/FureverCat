//
//  P3_BulletinBoardView.swift
//  FureverCat
//
//  Created by xia on 11/11/25.
//

import SwiftUI

struct P3_BulletinBoardView: View {
    @StateObject private var viewModel = BulletinBoardViewModel()
    @State private var showCreatePost = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(spacing: 0) {
                // Custom Navigation Bar
                HStack {
                    Text("Bulletin Board")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button(action: {
                        // Filter or search action
                    }) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.title3)
                            .foregroundColor(.orange)
                    }
                }
                .padding()
                .background(Color.white)
                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 2)
                
                // Posts List
                if viewModel.posts.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "note.text")
                            .font(.system(size: 60))
                            .foregroundColor(.gray.opacity(0.5))
                        
                        Text("No posts yet")
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        Text("Be the first to share something!")
                            .font(.subheadline)
                            .foregroundColor(.gray.opacity(0.7))
                    }
                    .frame(maxHeight: .infinity)
                } else {
                    ScrollView {
                        LazyVStack(spacing: 15) {
                            ForEach(viewModel.posts) { post in
                                PostCard(post: post, viewModel: viewModel)
                            }
                        }
                        .padding()
                    }
                }
            }
            
            // Floating Action Button
            Button(action: {
                showCreatePost = true
            }) {
                Image(systemName: "plus")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: 60, height: 60)
                    .background(Color.orange)
                    .clipShape(Circle())
                    .shadow(color: Color.orange.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            .padding(25)
        }
        .background(Color.gray.opacity(0.05))
        .sheet(isPresented: $showCreatePost) {
            CreatePostView(viewModel: viewModel, isPresented: $showCreatePost)
        }
    }
}

// Post Card Component
struct PostCard: View {
    let post: Post
    @ObservedObject var viewModel: BulletinBoardViewModel
    @State private var isLiked = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // User Info
            HStack {
                Circle()
                    .fill(Color.orange.opacity(0.3))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Text(String(post.userName.prefix(1)))
                            .font(.headline)
                            .foregroundColor(.orange)
                    )
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(post.userName)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    Text(post.createdAt.timeAgoDisplay())
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                // More Options
                Button(action: {}) {
                    Image(systemName: "ellipsis")
                        .foregroundColor(.gray)
                }
            }
            
            // Post Title
            Text(post.title)
                .font(.headline)
                .fontWeight(.bold)
            
            // Post Content
            Text(post.content)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)
            
            // Image if available
            if let imageURL = post.imageURL {
                Rectangle()
                    .fill(Color.gray.opacity(0.2))
                    .frame(height: 200)
                    .cornerRadius(12)
                    .overlay(
                        Image(systemName: "photo")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    )
            }
            
            Divider()
            
            // Actions
            HStack(spacing: 30) {
                // Like Button
                Button(action: {
                    isLiked.toggle()
                    if isLiked {
                        viewModel.likePost(postId: post.id)
                    }
                }) {
                    HStack(spacing: 5) {
                        Image(systemName: isLiked ? "heart.fill" : "heart")
                            .foregroundColor(isLiked ? .red : .gray)
                        Text("\(post.likes + (isLiked ? 1 : 0))")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                // Comment Button
                Button(action: {}) {
                    HStack(spacing: 5) {
                        Image(systemName: "message")
                            .foregroundColor(.gray)
                        Text("\(post.comments)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                
                Spacer()
                
                // Share Button
                Button(action: {}) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.gray)
                }
            }
            .font(.subheadline)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: 2)
    }
}

// Create Post View
struct CreatePostView: View {
    @ObservedObject var viewModel: BulletinBoardViewModel
    @Binding var isPresented: Bool
    @State private var title = ""
    @State private var content = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Title Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Title")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    TextField("What's this about?", text: $title)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
                
                // Content Input
                VStack(alignment: .leading, spacing: 8) {
                    Text("Content")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                    
                    TextEditor(text: $content)
                        .frame(height: 200)
                        .padding(8)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                }
                
                Spacer()
                
                // Post Button
                Button(action: {
                    if !title.isEmpty && !content.isEmpty {
                        viewModel.addPost(title: title, content: content)
                        isPresented = false
                    }
                }) {
                    Text("Post")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background((!title.isEmpty && !content.isEmpty) ? Color.orange : Color.gray)
                        .cornerRadius(12)
                }
                .disabled(title.isEmpty || content.isEmpty)
            }
            .padding()
            .navigationTitle("Create Post")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        isPresented = false
                    }
                }
            }
        }
    }
}

// Date Extension for Time Ago Display
extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: self, relativeTo: Date())
    }
}

#Preview {
    P3_BulletinBoardView()
}
