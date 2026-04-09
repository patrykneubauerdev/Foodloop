//
//  ProductDetailView.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 04/08/2025.
//


import SwiftUI

struct ProductDetailView: View {
    let cartItem: CartItem
    
    @StateObject private var viewModel: ProductDetailViewModel
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var cartViewModel: CartViewModel
    
    init(cartItem: CartItem) {
        self.cartItem = cartItem
        self._viewModel = StateObject(wrappedValue: ProductDetailViewModel(cartItem: cartItem))
    }
    
    private var product: Product {
        cartItem.product
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ProductImageView(product: product)
                    
                    VStack(spacing: 0) {
                        Text(product.localizedImageName)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                            .multilineTextAlignment(.center)
                            .frame(minHeight: 44)
                            .padding(.bottom, 16)
                        
                        if viewModel.hasBadges {
                            ProductBadgesView(product: product)
                                .padding(.bottom, 16)
                        }
                        
                        HStack(spacing: 8) {
                            Text("\(product.price, specifier: "%.2f") zł")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundStyle(.purpleLight)
                            
                            if viewModel.selectedQuantity > 1 {
                                Text("×\(viewModel.selectedQuantity)")
                                    .font(.title3)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.secondary)
                            }
                        }
                        .padding(.bottom, viewModel.hasBadges ? 16 : 8)
                        
                        VStack(spacing: 0) {
                            if !viewModel.hasBadges {
                                Spacer(minLength: 0)
                            }
                            
                            Text(product.localizedDescription)
                                .font(.body)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 16)
                                .lineLimit(6)
                        }
                        .frame(height: viewModel.hasBadges ? 100 : 120)
                        .padding(.bottom, 16)
                        
                        
                        Divider()
                            .padding(.horizontal, 16)
                            .padding(.bottom, 16)
                        
                        QuantityControlsView(viewModel: viewModel)
                            .padding(.bottom, 16)
                        
                        if viewModel.selectedQuantity > 1 {
                            VStack(spacing: 8) {
                                HStack {
                                    Text("quantity")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    
                                    
                                    
                                    Text("\(viewModel.selectedQuantity)")
                                        .font(.subheadline)
                                        .foregroundStyle(.secondary)
                                    
                                    Spacer()
                                }
                                
                                HStack {
                                    Text("total")
                                        .font(.headline)
                                        .foregroundStyle(.primary)
                                    
                                    Spacer()
                                    
                                    Text("\(viewModel.totalPrice, specifier: "%.2f") zł")
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundStyle(.purpleLight)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 16)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color.bone)
                            )
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.bottom, 32)
                }
            }
            .padding(.top, 12)
            .background(Color.boneBackground)
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .scrollDisabled(true)
            .scrollIndicators(.hidden)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                    .foregroundStyle(.purpleLight)
                    .fontWeight(.medium)
                }
            }
            .onAppear {
                viewModel.setCartViewModel(cartViewModel)
            }
        }
    }
}
