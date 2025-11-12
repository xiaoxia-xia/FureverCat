//
//  AuthViewModel.swift
//  FureverCat
//
//  Created by xia on 11/11/25.
//

import Foundation
import Combine


class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var errorMessage: String?
    @Published var isLoading = false
    
    func signIn(email: String, password: String) {
        isLoading = true
        errorMessage = nil
        
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            // Mock authentication - replace with actual API call
            if !email.isEmpty && !password.isEmpty {
                self?.currentUser = User(email: email, name: "Pet Lover")
                self?.isAuthenticated = true
            } else {
                self?.errorMessage = "Please enter email and password"
            }
            self?.isLoading = false
        }
    }
    
    func signOut() {
        currentUser = nil
        isAuthenticated = false
    }
}
