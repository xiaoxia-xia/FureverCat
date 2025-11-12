import SwiftUI

struct P6_ShopView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "cart.fill")
                .font(.system(size: 80))
                .foregroundColor(.orange)
            
            Text("Shop")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Coming Soon!")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("Browse and purchase pet supplies, food, toys, and accessories.")
                .font(.caption)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.orange.opacity(0.05))
        .navigationTitle("Shop")
    }
}

#Preview {
    NavigationStack {
        P6_ShopView()
    }
}
