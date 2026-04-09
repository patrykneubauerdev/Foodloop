//
//  CartItemRow.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 07/04/2026.
//

import SwiftUI

struct CartItemRow: View {
    let item: CartItem
    @EnvironmentObject var cartViewModel: CartViewModel
    @State private var showDeleteAlert = false
    @State private var showProductDetail = false
    
    var body: some View {
        HStack(spacing: 0) {
            
            Button(action: {
                showProductDetail = true
            }) {
                CartItemImageView(product: item.product)
            }
            .buttonStyle(PlainButtonStyle())
            
            VStack(alignment: .leading, spacing: 0) {
                
                HStack {
                    Text(item.product.localizedImageName)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .truncationMode(.tail)
                    
                    Spacer()
                    
                    Button(action: {
                        showDeleteAlert = true
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(.white)
                            .frame(width: 24, height: 24)
                            .background(
                                Circle()
                                    .fill(Color.purpleLight)
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .frame(height: 44)
                
                
                VStack(alignment: .leading, spacing: 6) {
                    if item.product.isBestseller || item.product.isSpicy || item.product.isVegan {
                        HStack(spacing: 6) {
                            if item.product.isBestseller {
                                IconBadge(icon: "crown", color: .orange)
                            }
                            if item.product.isSpicy {
                                IconBadge(icon: "flame", color: .red)
                            }
                            if item.product.isVegan {
                                IconBadge(icon: "leaf", color: .green)
                            }
                        }
                        .frame(height: 18)
                        
                        Text("\(item.product.localizedDescription)")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .multilineTextAlignment(.leading)
                            .frame(height: 16, alignment: .top)
                    } else {
                        Text("\(item.product.localizedDescription)")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                            .lineLimit(3)
                            .truncationMode(.tail)
                            .multilineTextAlignment(.leading)
                            .frame(height: 40, alignment: .top)
                    }
                }
                .frame(height: 46)
                
                Spacer()
                
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("(\(item.product.price, specifier: "%.2f") zł)")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .fontWeight(.medium)
                        
                        Text("\(item.totalPrice, specifier: "%.2f") zł")
                            .font(.subheadline)
                            .foregroundStyle(.purpleLight)
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 6) {
                        CartItemQuantityControls(item: item, showDeleteAlert: $showDeleteAlert)
                            .environmentObject(cartViewModel)
                    }
                }
                .frame(height: 42)
            }
            .padding(.leading, 16)
            .padding(.trailing, 20)
            .padding(.vertical, 18)
        }
        .frame(height: 150)
        .background(Color.bone)
        .cornerRadius(16)
        .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        .alert("remove-product-question", isPresented: $showDeleteAlert) {
            Button("cancel", role: .cancel) { }
            Button("delete", role: .destructive) {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.8)) {
                    cartViewModel.removeFromCart(item: item)
                }
            }
        } message: {
            Text("remove-product-message \(item.product.localizedImageName)")
        }
        .sheet(isPresented: $showProductDetail) {
            ProductDetailView(cartItem: item)
                .environmentObject(cartViewModel)
        }
    }
}
