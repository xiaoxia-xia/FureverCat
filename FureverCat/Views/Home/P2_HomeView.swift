//
//  P2_HomeView.swift
//  FureverCat
//
//  Created by xia on 11/11/25.
//

import SwiftUI

struct P2_HomeView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @State private var selectedPage: String? = nil
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background gradient
                LinearGradient(gradient: Gradient(colors: [Color.orange.opacity(0.1), Color.white]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    VStack(spacing: 10) {
                        HStack {
                            VStack(alignment: .leading, spacing: 5) {
                                Text("Welcome Back!")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                
                                Text(authViewModel.currentUser?.name ?? "Pet Lover")
                                    .font(.title2)
                                    .fontWeight(.bold)
                            }
                            
                            Spacer()
                            
                            // Profile Picture
                            Circle()
                                .fill(Color.orange.opacity(0.3))
                                .frame(width: 50, height: 50)
                                .overlay(
                                    Image(systemName: "person.fill")
                                        .foregroundColor(.orange)
                                )
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)
                        
                        // Search Bar (Optional)
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                            Text("Search for pets, products, or services...")
                                .foregroundColor(.gray)
                                .font(.subheadline)
                            Spacer()
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .padding(.top, 10)
                    }
                    .padding(.bottom, 30)
                    
                    // Main Content - 6 Icons Grid
                    ScrollView {
                        VStack(spacing: 25) {
                            // Row 1
                            HStack(spacing: 20) {
                                NavigationLink(destination: P3_BulletinBoardView()) {
                                    HomeIconButton(
                                        iconName: "newspaper.fill",
                                        title: "Bulletin Board",
                                        color: .blue,
                                        imageName: "home_icon_bulletin"
                                    )
                                }
                                
                                NavigationLink(destination: P4_PetView()) {
                                    HomeIconButton(
                                        iconName: "pawprint.fill",
                                        title: "My Pets",
                                        color: .purple,
                                        imageName: "home_icon_pet"
                                    )
                                }
                            }
                            .padding(.horizontal)
                            
                            // Row 2
                            HStack(spacing: 20) {
                                NavigationLink(destination: P5_MapView()) {
                                    HomeIconButton(
                                        iconName: "map.fill",
                                        title: "Map",
                                        color: .green,
                                        imageName: "home_icon_map"
                                    )
                                }
                                
                                NavigationLink(destination: P6_ShopView()) {
                                    HomeIconButton(
                                        iconName: "cart.fill",
                                        title: "Shop",
                                        color: .orange,
                                        imageName: "home_icon_shop"
                                    )
                                }
                            }
                            .padding(.horizontal)
                            
                            // Row 3
                            HStack(spacing: 20) {
                                NavigationLink(destination: P7_ProfileView()) {
                                    HomeIconButton(
                                        iconName: "person.fill",
                                        title: "Profile",
                                        color: .pink,
                                        imageName: "home_icon_profile"
                                    )
                                }
                                
                                // Placeholder for 6th icon (future feature)
                                HomeIconButton(
                                    iconName: "ellipsis.circle.fill",
                                    title: "More",
                                    color: .gray,
                                    imageName: "home_icon_more"
                                )
                                .opacity(0.5)
                            }
                            .padding(.horizontal)
                        }
                        .padding(.top, 10)
                    }
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

// Home Icon Button Component
struct HomeIconButton: View {
    let iconName: String
    let title: String
    let color: Color
    let imageName: String
    
    var body: some View {
        VStack(spacing: 15) {
            // Icon Circle
            ZStack {
                Circle()
                    .fill(color.opacity(0.2))
                    .frame(width: 100, height: 100)
                
                // Try to load custom image, fallback to SF Symbol
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(color)
                    .onAppear {
                        // If custom image doesn't exist, use SF Symbol
                    }
                
                // Fallback SF Symbol
                Image(systemName: iconName)
                    .font(.system(size: 40))
                    .foregroundColor(color)
            }
            
            // Title
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
                .multilineTextAlignment(.center)
                .frame(height: 35)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    P2_HomeView()
        .environmentObject(AuthViewModel())
}
