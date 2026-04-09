//
//  OrderDetailView.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 07/04/2026.
//

import SwiftUI


struct OrderDetailView: View {
    let order: Order
    @Environment(\.dismiss) private var dismiss
 
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 12) {
                HStack {
                    Spacer()
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .fontWeight(.medium)
                            .imageScale(.medium)
                            .foregroundStyle(.purpleLight)
                            .frame(width: 38, height: 38)
                            .background(Color.purpleLight.opacity(0.15))
                            .clipShape(Circle())
                    }
                }
                .padding(.bottom, 4)
 
           
                Text("order-number-colon \(order.orderNumber)")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.purpleLight)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.purpleLight.opacity(0.1))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.purpleLight.opacity(0.3), lineWidth: 1)
                    )
 
              
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 20)
            .frame(maxWidth: .infinity)
 
            Divider()
 
            ScrollView {
                VStack(spacing: 16) {
                    OrderDetailsCard(order: order)
                    OrderItemsCard(items: order.items)
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
            }
            .scrollIndicators(.hidden)
            Divider()
            .safeAreaInset(edge: .bottom) {
                Color.clear.frame(height: 15)
            }
        }
        .background(Color.boneBackground)
    }
}
