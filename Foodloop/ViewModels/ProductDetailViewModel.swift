//
//  ProductDetailViewModel.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 04/08/2025.
//


import Foundation
import SwiftUI

@MainActor
class ProductDetailViewModel: ObservableObject {
    @Published var selectedQuantity: Int
    
    private let product: Product
    private let cartItem: CartItem
    private var cartViewModel: CartViewModel?
    
    init(cartItem: CartItem) {
        self.cartItem = cartItem
        self.product = cartItem.product
        self.selectedQuantity = cartItem.quantity
    }
    
    func setCartViewModel(_ cartViewModel: CartViewModel) {
        self.cartViewModel = cartViewModel
    }
    
    var hasBadges: Bool {
        product.isBestseller || product.isSpicy || product.isVegan
    }
    
    var totalPrice: Double {
        product.price * Double(selectedQuantity)
    }
    
    var canDecreaseQuantity: Bool {
        selectedQuantity > 1
    }
    
    var canIncreaseQuantity: Bool {
        selectedQuantity < 99
    }
    
    func decreaseQuantity() {
        if canDecreaseQuantity {
            selectedQuantity -= 1
            updateCartQuantity()
        }
    }
    
    func increaseQuantity() {
        if canIncreaseQuantity {
            selectedQuantity += 1
            updateCartQuantity()
        }
    }
    
    private func updateCartQuantity() {
        guard let cartViewModel = cartViewModel else { return }
        cartViewModel.updateQuantity(for: cartItem, newQuantity: selectedQuantity)
    }
}
