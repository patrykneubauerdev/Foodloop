//
//  OrderItemsCard.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 07/04/2026.
//

import SwiftUI
 
// MARK: - Order Items Card
 
struct OrderItemsCard: View {
    let items: [OrderItem]
 
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("ordered-items")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                Spacer()
            }
 
            VStack(spacing: 12) {
                ForEach(items.indices, id: \.self) { index in
                    let item = items[index]
                    OrderItemRow(item: item)
 
                    if index < items.count - 1 {
                        Divider()
                            .background(Color.purpleLight.opacity(0.2))
                    }
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .background(Color.bone)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
}
 


// MARK: - Order Item Row
 
struct OrderItemRow: View {
    let item: OrderItem
 
    var body: some View {
        HStack(spacing: 12) {
            Text("\(item.quantity)×")
                .font(.subheadline)
                .fontWeight(.bold)
                .foregroundStyle(.purpleLight)
                .frame(width: 30, alignment: .leading)
 
            VStack(alignment: .leading, spacing: 2) {
                Text(item.productName)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .foregroundStyle(.primary)
                    .lineLimit(2)
 
                Text("\(item.productPrice.formattedPrice) each")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
 
            Spacer()
 
            Text(item.totalPrice.formattedPrice)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(.purpleLight)
        }
    }
}
