//
//  EmptyCartView.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 15/07/2025.
//

import SwiftUI

struct EmptyCartView: View {
    var body: some View {
        VStack(spacing: 32) {
            VStack(spacing: 24) {
               
                ZStack {
                    Circle()
                        .fill(Color.purpleLight.opacity(0.1))
                        .frame(width: 120, height: 120)
                    
                    ZStack {
                        Image(systemName: "fork.knife.circle.fill")
                            .font(.system(size: 48))
                            .foregroundStyle(.purpleLight)
                        
                        Image(systemName: "cart.badge.plus")
                            .font(.system(size: 18))
                            .foregroundStyle(.white)
                            .background(
                                Circle()
                                    .fill(Color.purpleLight)
                                    .frame(width: 28, height: 28)
                            )
                            .offset(x: 25, y: -25)
                    }
                }
                .scaleEffect(1.0)
                .animation(.easeInOut(duration: 2.0).repeatForever(autoreverses: true), value: UUID())
                
               
                VStack(spacing: 12) {
                    Text(String(localized: "empty-cart"))
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundStyle(.primary)
                    
                    Text(String(localized: "empty-cart-message"))
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .lineLimit(3)
                }
            }
            
          
            Button(action: {
                NotificationCenter.default.post(name: NSNotification.Name("SwitchToMenuTab"), object: nil)
            }) {
                HStack(spacing: 12) {
                    Image(systemName: "fork.knife")
                        .font(.system(size: 16, weight: .medium))
                    
                    Text("browse-menu")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.purpleLight)
                )
            }
            .buttonStyle(PlainButtonStyle())
            .scaleEffect(1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: UUID())
            .padding(.horizontal, 32)
        }
        .padding(.horizontal, 24)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.boneBackground)
    }
}
