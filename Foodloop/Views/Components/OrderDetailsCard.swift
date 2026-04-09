//
//  OrderDetailsCard.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 07/04/2026.
//

import SwiftUI
 
// MARK: - Order Details Card
 
struct OrderDetailsCard: View {
    let order: Order
 
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Text("order-details")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                Spacer()
            }
 
            VStack(spacing: 12) {
                DetailRow(title: "table-number", value: "\(order.tableNumber)")
                DetailRow(title: "order-time", value: formatTime(order.createdAt))
                DetailRow(title: "total-amount", value: order.totalPrice.formattedPrice, isPrice: true)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 20)
        .background(Color.bone)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
    }
 
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}
 
// MARK: - Detail Row
 
struct DetailRow: View {
    let title: String
    let value: String
    let isPrice: Bool
 
    init(title: String, value: String, isPrice: Bool = false) {
        self.title = title
        self.value = value
        self.isPrice = isPrice
    }
 
    var body: some View {
        HStack {
            Text(LocalizedStringKey(title))
                .font(.subheadline)
                .foregroundStyle(.secondary)
 
            Spacer()
 
            Text(value)
                .font(.subheadline)
                .fontWeight(isPrice ? .bold : .medium)
                .foregroundStyle(isPrice ? .purpleLight : .primary)
        }
    }
}
