//
//  CartItemQuantityControls.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 15/07/2025.
//

import SwiftUI

struct CartItemQuantityControls: View {
    let item: CartItem
    @EnvironmentObject var cartViewModel: CartViewModel
    @Binding var showDeleteAlert: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            Button(action: {
                if item.quantity == 1 {
                    showDeleteAlert = true
                } else {
                    cartViewModel.updateQuantity(for: item, newQuantity: item.quantity - 1)
                }
            }) {
                Image(systemName: item.quantity == 1 ? "trash" : "minus")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(width: 24, height: 24)
                    .background(
                        Circle()
                            .fill(.purpleLight)
                    )
            }
            
            VStack(spacing: 2) {
                Text("quantity")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .fontWeight(.medium)
                    .minimumScaleFactor(0.6)
                    .lineLimit(1)
                
                Text("\(item.quantity)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                    .frame(minWidth: 24)
            }
            
            Button(action: {
                if item.quantity < 99 {
                    cartViewModel.updateQuantity(for: item, newQuantity: item.quantity + 1)
                }
            }) {
                Image(systemName: "plus")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(width: 24, height: 24)
                    .background(
                        Circle()
                            .fill(item.quantity < 99 ? .purpleLight : .purpleLight.opacity(0.3))
                    )
            }
            .disabled(item.quantity >= 99)
        }
    }
}
