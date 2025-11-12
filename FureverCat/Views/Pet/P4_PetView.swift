import SwiftUI

struct P4_PetView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "pawprint.fill")
                .font(.system(size: 80))
                .foregroundColor(.purple)
            
            Text("My Pets")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Coming Soon!")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("Manage your pet profiles, vaccination records, and more.")
                .font(.caption)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.purple.opacity(0.05))
        .navigationTitle("My Pets")
    }
}

#Preview {
    NavigationStack {
        P4_PetView()
    }
}
