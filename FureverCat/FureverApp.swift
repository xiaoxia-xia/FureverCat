//
//  FureverApp.swift
//  FureverCat
//
//  Created by xia on 11/11/25.
//

import SwiftUI

@main
struct FureverApp: App {
    @StateObject private var authViewModel = AuthViewModel()
    
    var body: some Scene {
        WindowGroup {
            if authViewModel.isAuthenticated {
                P2_HomeView()
                    .environmentObject(authViewModel)
            } else {
                P1_SignInView()
                    .environmentObject(authViewModel)
            }
        }
    }
}
