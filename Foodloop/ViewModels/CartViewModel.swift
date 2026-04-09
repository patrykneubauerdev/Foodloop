//
//  CartViewModel.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 09/07/2025.
//

import Foundation
import SwiftUI

@MainActor
class CartViewModel: ObservableObject {
    @Published var items: [CartItem] = []
    @Published var showProductAddedAlert = false
    @Published var lastAddedProductName = ""
    
    var totalItems: Int {
        items.reduce(0) { $0 + $1.quantity }
    }
    
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.totalPrice }
    }
    
    var isEmpty: Bool {
        items.isEmpty
    }
    
    func addToCart(product: Product, quantity: Int) {
        if let existingIndex = items.firstIndex(where: { $0.product.id == product.id }) {
            items[existingIndex].quantity += quantity
        } else {
            let cartItem = CartItem(product: product, quantity: quantity)
            items.append(cartItem)
        }
        
        lastAddedProductName = product.localizedImageName
        showProductAddedAlert = true
    }
    
    func removeFromCart(item: CartItem) {
        items.removeAll { $0.id == item.id }
    }
    
    func updateQuantity(for item: CartItem, newQuantity: Int) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            if newQuantity <= 0 {
                items.remove(at: index)
            } else {
                items[index].quantity = newQuantity
            }
        }
    }
    
    func clearCart() {
        items.removeAll()
    }
}
