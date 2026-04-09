//
//  CartView.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 16/06/2025.
//


import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    
    @State private var hasAnimated = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.boneBackground
                    .ignoresSafeArea()
                
                if cartViewModel.isEmpty {
                    EmptyCartView()
                        .scaleEffect(hasAnimated ? 1.0 : 0.85)
                        .opacity(hasAnimated ? 1.0 : 0.0)
                        .animation(.spring(response: 0.7, dampingFraction: 0.7), value: hasAnimated)
                } else {
                    cartContentView
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            if !hasAnimated {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    hasAnimated = true
                }
            }
        }
    }
    
    private var cartContentView: some View {
        ScrollView {
            LazyVStack(spacing: 14) {
                ForEach(cartViewModel.items) { item in
                    CartItemRow(item: item)
                        .environmentObject(cartViewModel)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
        .scrollIndicators(.hidden)
        .scrollEdgeEffectStyle(.soft, for: .top)
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(
                        LinearGradient(
                            colors: [
                                Color.boneBackground.opacity(0),
                                Color.boneBackground.opacity(0.5),
                                Color.boneBackground.opacity(0.8),
                                Color.boneBackground
                            ],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .frame(height: 30)
                
                CartSummaryView()
                    .environmentObject(cartViewModel)
            }
        }
    }
}



#Preview {
    CartView()
        .environmentObject(CartViewModel())
}
