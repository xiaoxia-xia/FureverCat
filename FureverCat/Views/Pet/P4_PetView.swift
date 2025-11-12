import SwiftUI

// Pet Model
struct Pet: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    var bondLevel: Int
    let type: String
}

struct P4_PetView: View {
    @Environment(\.dismiss) var dismiss
    @State private var pets: [Pet] = [
        Pet(name: "Luna", imageName: "pet_luna", bondLevel: 85, type: "Siamese Cat"),
        Pet(name: "Babes", imageName: "pet_babes", bondLevel: 92, type: "Ragdoll Cat"),
        Pet(name: "Buenos Aires", imageName: "pet_buenos_aires", bondLevel: 78, type: "Maine Coon"),
        Pet(name: "Squid", imageName: "pet_squid", bondLevel: 88, type: "Scottish Fold"),
        Pet(name: "Babs", imageName: "pet_babs", bondLevel: 95, type: "Persian Cat"),
        Pet(name: "Harley", imageName: "pet_harley", bondLevel: 80, type: "Bengal Cat"),
        Pet(name: "Taipei", imageName: "pet_taipei", bondLevel: 90, type: "British Shorthair")
    ]
    @State private var currentPetIndex = 0
    @State private var showActionFeedback = false
    @State private var actionMessage = ""
    @State private var showFloatingHearts = false
    @State private var showFloatingCoins = false
    @State private var navigateToMap = false
    
    var currentPet: Pet {
        pets[currentPetIndex]
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.7, green: 0.9, blue: 1.0),
                        Color(red: 1.0, green: 0.85, blue: 0.95)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Top Navigation Bar
                    HStack {
                        // Back Button
                        Button(action: {
                            dismiss()
                        }) {
                            Circle()
                                .fill(Color.white.opacity(0.7))
                                .frame(width: 50, height: 50)
                                .overlay(
                                    Image(systemName: "arrow.left")
                                        .font(.title3)
                                        .foregroundColor(.gray)
                                )
                        }
                        
                        Spacer()
                        
                        // Title
                        Text("Furever")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        // Map Button
                        NavigationLink(destination: P5_MapView()) {
                            Circle()
                                .fill(Color.white.opacity(0.7))
                                .frame(width: 50, height: 50)
                                .overlay(
                                    Image(systemName: "bell.fill")
                                        .font(.title3)
                                        .foregroundColor(.blue)
                                )
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    Spacer()
                    
                    // Cat Display Area
                    ZStack {
                        // Swipeable Pet Images
                        TabView(selection: $currentPetIndex) {
                            ForEach(0..<pets.count, id: \.self) { index in
                                PetImageView(pet: pets[index])
                                    .tag(index)
                            }
                        }
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                        .frame(height: 500)
                        
                        // Floating Hearts Animation
                        if showFloatingHearts {
                            FloatingHeartsView()
                        }
                        
                        // Floating Coins Animation
                        if showFloatingCoins {
                            FloatingCoinsView()
                        }
                    }
                    
                    // Pet Name Indicator
                    HStack(spacing: 8) {
                        ForEach(0..<pets.count, id: \.self) { index in
                            Circle()
                                .fill(currentPetIndex == index ? Color.white : Color.white.opacity(0.4))
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.bottom, 10)
                    
                    // Action Buttons (Feed, Play, Talk)
                    HStack(spacing: 25) {
                        ActionButton(
                            icon: "fork.knife",
                            label: "Feed",
                            backgroundColor: Color.white,
                            iconColor: .orange
                        ) {
                            performAction("Feed", message: "🍽️ Yum! Luna enjoyed the meal!", showCoins: true)
                        }
                        
                        ActionButton(
                            icon: "house.fill",
                            label: "Play",
                            backgroundColor: Color(red: 0.4, green: 0.8, blue: 1.0),
                            iconColor: .white,
                            isLarge: true
                        ) {
                            performAction("Play", message: "🎾 Playtime! Luna is so happy!", showHearts: true)
                        }
                        
                        ActionButton(
                            icon: "message.fill",
                            label: "Talk",
                            backgroundColor: Color.white,
                            iconColor: .pink
                        ) {
                            performAction("Talk", message: "😸 Meow! Luna purrs happily")
                        }
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
                    
                    // Bond Level Bar
                    HStack(spacing: 15) {
                        // Bond Level Progress
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                Text("Bond Level \(currentPet.bondLevel)/100")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                            
                            GeometryReader { geometry in
                                ZStack(alignment: .leading) {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(Color.white.opacity(0.5))
                                        .frame(height: 12)
                                    
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color.cyan, Color.blue]),
                                                startPoint: .leading,
                                                endPoint: .trailing
                                            )
                                        )
                                        .frame(width: geometry.size.width * CGFloat(currentPet.bondLevel) / 100, height: 12)
                                }
                            }
                            .frame(height: 12)
                        }
                        
                        // Map Button
                        NavigationLink(destination: P5_MapView()) {
                            Circle()
                                .fill(Color.white)
                                .frame(width: 60, height: 60)
                                .overlay(
                                    Image(systemName: "map.fill")
                                        .font(.title2)
                                        .foregroundColor(.green)
                                )
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                        }
                    }
                    .padding(.horizontal, 25)
                    .padding(.bottom, 30)
                }
                
                // Action Feedback Overlay
                if showActionFeedback {
                    VStack {
                        Text(actionMessage)
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(15)
                            .padding(.top, 100)
                        Spacer()
                    }
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    // Perform Action Function
    func performAction(_ action: String, message: String, showHearts: Bool = false, showCoins: Bool = false) {
        actionMessage = message
        withAnimation(.easeInOut(duration: 0.3)) {
            showActionFeedback = true
        }
        
        if showHearts {
            showFloatingHearts = true
        }
        if showCoins {
            showFloatingCoins = true
        }
        
        // Increase bond level
        pets[currentPetIndex].bondLevel = min(100, pets[currentPetIndex].bondLevel + 1)
        
        // Hide feedback after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showActionFeedback = false
                showFloatingHearts = false
                showFloatingCoins = false
            }
        }
    }
}

// Pet Image View Component
struct PetImageView: View {
    let pet: Pet
    
    var body: some View {
        VStack {
            // Cat image with proper fallback
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.3))
                    .frame(width: 300, height: 300)
                
                // Custom pet image
                if UIImage(named: pet.imageName) != nil {
                    Image(pet.imageName)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 300, height: 300)
                        .clipShape(Circle())
                } else {
                    // Fallback cat icon only if image doesn't exist
                    Image(systemName: "cat.fill")
                        .font(.system(size: 120))
                        .foregroundColor(.white.opacity(0.5))
                }
            }
            
            Text(pet.name)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top, 10)
            
            Text(pet.type)
                .font(.subheadline)
                .foregroundColor(.white.opacity(0.8))
        }
    }
}

// Action Button Component
struct ActionButton: View {
    let icon: String
    let label: String
    let backgroundColor: Color
    let iconColor: Color
    var isLarge: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 8) {
                ZStack {
                    Circle()
                        .fill(backgroundColor)
                        .frame(width: isLarge ? 90 : 70, height: isLarge ? 90 : 70)
                        .shadow(color: Color.black.opacity(0.15), radius: 8, x: 0, y: 4)
                    
                    Image(systemName: icon)
                        .font(.system(size: isLarge ? 35 : 28))
                        .foregroundColor(iconColor)
                }
                
                Text(label)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
            }
        }
    }
}

// Floating Hearts Animation
struct FloatingHeartsView: View {
    @State private var hearts: [HeartItem] = []
    
    var body: some View {
        ZStack {
            ForEach(hearts) { heart in
                Image(systemName: "heart.fill")
                    .font(.system(size: heart.size))
                    .foregroundColor(.blue)
                    .opacity(heart.opacity)
                    .offset(x: heart.x, y: heart.y)
            }
        }
        .onAppear {
            startAnimation()
        }
    }
    
    func startAnimation() {
        for i in 0..<5 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.2) {
                let heart = HeartItem()
                hearts.append(heart)
                
                withAnimation(.easeOut(duration: 1.5)) {
                    if let index = hearts.firstIndex(where: { $0.id == heart.id }) {
                        hearts[index].y = -300
                        hearts[index].opacity = 0
                    }
                }
            }
        }
    }
}

struct HeartItem: Identifiable {
    let id = UUID()
    var x: CGFloat = CGFloat.random(in: -50...50)
    var y: CGFloat = 0
    var size: CGFloat = CGFloat.random(in: 20...40)
    var opacity: Double = 1.0
}

// Floating Coins Animation
struct FloatingCoinsView: View {
    @State private var coins: [CoinItem] = []
    
    var body: some View {
        ZStack {
            ForEach(coins) { coin in
                Image(systemName: "bitcoinsign.circle.fill")
                    .font(.system(size: coin.size))
                    .foregroundColor(.orange)
                    .opacity(coin.opacity)
                    .offset(x: coin.x, y: coin.y)
                    .rotationEffect(.degrees(coin.rotation))
            }
        }
        .onAppear {
            startAnimation()
        }
    }
    
    func startAnimation() {
        for i in 0..<6 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.15) {
                let coin = CoinItem()
                coins.append(coin)
                
                withAnimation(.easeOut(duration: 1.5)) {
                    if let index = coins.firstIndex(where: { $0.id == coin.id }) {
                        coins[index].y = -300
                        coins[index].opacity = 0
                        coins[index].rotation = 360
                    }
                }
            }
        }
    }
}

struct CoinItem: Identifiable {
    let id = UUID()
    var x: CGFloat = CGFloat.random(in: -70...70)
    var y: CGFloat = 0
    var size: CGFloat = CGFloat.random(in: 25...35)
    var opacity: Double = 1.0
    var rotation: Double = 0
}

#Preview {
    P4_PetView()
}
