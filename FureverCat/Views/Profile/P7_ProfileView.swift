import SwiftUI

struct P7_ProfileView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        VStack(spacing: 20) {
            // Profile Picture
            Circle()
                .fill(Color.pink.opacity(0.3))
                .frame(width: 100, height: 100)
                .overlay(
                    Image(systemName: "person.fill")
                        .font(.system(size: 50))
                        .foregroundColor(.pink)
                )
            
            Text(authViewModel.currentUser?.name ?? "User")
                .font(.title2)
                .fontWeight(.bold)
            
            Text(authViewModel.currentUser?.email ?? "")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Divider()
                .padding(.vertical)
            
            // Profile Options (Placeholder)
            VStack(spacing: 15) {
                ProfileOptionRow(icon: "person.circle", title: "Edit Profile", color: .blue)
                ProfileOptionRow(icon: "bell", title: "Notifications", color: .orange)
                ProfileOptionRow(icon: "lock", title: "Privacy", color: .purple)
                ProfileOptionRow(icon: "gear", title: "Settings", color: .gray)
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Sign Out Button
            Button(action: {
                authViewModel.signOut()
            }) {
                Text("Sign Out")
                    .font(.headline)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.05))
        .navigationTitle("Profile")
    }
}

// Profile Option Row Component
struct ProfileOptionRow: View {
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(color)
                .frame(width: 30)
            
            Text(title)
                .font(.body)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
    }
}

#Preview {
    NavigationStack {
        P7_ProfileView()
            .environmentObject(AuthViewModel())
    }
}
