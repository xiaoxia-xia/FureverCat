//
//  P5_MapView.swift
//  FureverCat
//
//  Created by xia on 11/11/25.
//

import SwiftUI

struct P5_MapView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "map.fill")
                .font(.system(size: 80))
                .foregroundColor(.green)
            
            Text("Map")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Coming Soon!")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Text("Find nearby pet parks, vets, pet stores, and more.")
                .font(.caption)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.green.opacity(0.05))
        .navigationTitle("Map")
    }
}

#Preview {
    NavigationStack {
        P5_MapView()
    }
}
