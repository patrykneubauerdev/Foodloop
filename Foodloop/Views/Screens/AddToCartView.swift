//
//  AddToCartView.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 02/07/2025.
//

import SwiftUI

struct AddToCartView: View {
    let product: Product
    
    @StateObject private var viewModel: AddToCartViewModel
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var cartViewModel: CartViewModel
    
    init(product: Product) {
        self.product = product
        self._viewModel = StateObject(wrappedValue: AddToCartViewModel(product: product))
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
                        
                        Text("\(product.price, specifier: "%.2f") zł")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundStyle(.purpleLight)
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
                                .lineLimit(4)
                        }
                        .frame(height: viewModel.hasBadges ? 70 : 84)
                        .padding(.bottom, 16)
                        
                        Divider()
                            .padding(.horizontal, 16)
                            .padding(.top, viewModel.hasBadges ? 0 : 24)
                        
                        QuantitySelectorView(viewModel: viewModel)
                        
                        Button(action: {
                            viewModel.addToCart()
                        }) {
                            HStack {
                                Image(systemName: "cart.badge.plus")
                                    .font(.system(size: 16, weight: .medium))
                                
                                Text("\(String(localized: "add-to-cart")) • \(viewModel.totalPrice, specifier: "%.2f") zł")
                                    .font(.headline)
                                    .fontWeight(.semibold)
                            }
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 56)
                            .background(.purpleLight)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
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
            .alert(String(localized: "product-added"), isPresented: $viewModel.showProductAddedAlert) {
                Button(String(localized: "continue-shopping")) {
                    dismiss()
                }
                
                Button(String(localized: "go-to-cart")) {
                    dismiss()
                    NotificationCenter.default.post(name: NSNotification.Name("SwitchToCartTab"), object: nil)
                }
            } message: {
                Text(viewModel.getAlertMessage())
                    .multilineTextAlignment(.center)
            }
            .onAppear {
                viewModel.setCartViewModel(cartViewModel)
            }
        }
    }
}
