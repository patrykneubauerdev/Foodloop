//
//  OrderCard.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 07/04/2026.
//


import SwiftUI


struct OrderCard: View {
    let order: Order
    @State private var showDetails = false
 
    var body: some View {
        VStack(spacing: 0) {
          
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                 
                    Text("order-number-colon \(order.orderNumber)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.purpleLight)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.purpleLight.opacity(0.1))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.purpleLight.opacity(0.3), lineWidth: 1)
                        )
 
                  
                    HStack(spacing: 4) {
                        Text("table-number-colon \(order.tableNumber)")
                            .font(.caption)
                    }
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 3)
                    .background(Color.secondary.opacity(0.07))
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                }
 
                Spacer()
 
                Text(formatDate(order.createdAt))
                    .font(.caption)
                    .foregroundStyle(.purpleLight)
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 16)
 
          
            VStack(spacing: 8) {
                ForEach(Array(order.items.prefix(3).enumerated()), id: \.offset) { index, item in
                    HStack {
                        Text("\(item.quantity)×")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.purpleLight)
                            .frame(width: 25, alignment: .leading)
 
                        Text(item.productName)
                            .font(.caption)
                            .foregroundStyle(.primary)
                            .lineLimit(1)
 
                        Spacer()
 
                        Text(formatPrice(item.totalPrice))
                            .font(.caption)
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                    }
                }
 
                if order.items.count > 3 {
                    HStack {
                        Text("and-more-items \(order.items.count - 3)")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .italic()
 
                        Spacer()
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 16)
 
         
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("total")
                        .font(.caption)
                        .foregroundStyle(.secondary)
 
                    Text(formatPrice(order.totalPrice))
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(.purpleLight)
                }
 
                Spacer()
 
                Button(action: {
                    showDetails = true
                }) {
                    HStack(spacing: 6) {
                        Text("details")
                            .font(.subheadline)
                            .fontWeight(.medium)
 
                        Image(systemName: "chevron.right")
                            .font(.system(size: 12, weight: .medium))
                    }
                    .foregroundStyle(.purpleLight)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.purpleLight.opacity(0.6), lineWidth: 1)
                    )
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .background(Color.bone)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        .sheet(isPresented: $showDetails) {
            OrderDetailView(order: order)
        }
    }
 
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
 
    private func formatPrice(_ value: Double) -> String {
        let formatted = String(format: "%.2f", value).replacingOccurrences(of: ".", with: ",")
        return "\(formatted) zł"
    }
}
