//
//  AddToCartViewModel.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 15/07/2025.
//


import Foundation
import SwiftUI

@MainActor
class AddToCartViewModel: ObservableObject {
    @Published var selectedQuantity = 1
    @Published var showProductAddedAlert = false
    
    private let product: Product
    private var cartViewModel: CartViewModel?
    
    init(product: Product) {
        self.product = product
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
        }
    }
    
    func increaseQuantity() {
        if canIncreaseQuantity {
            selectedQuantity += 1
        }
    }
    
    func addToCart() {
        guard let cartViewModel = cartViewModel else { return }
        cartViewModel.addToCart(product: product, quantity: selectedQuantity)
        showProductAddedAlert = true
    }
    
    func getAlertMessage() -> String {
        let baseMessage = "\(String(localized: "added-to-cart")) \(product.localizedImageName)"
        return selectedQuantity > 1 ? baseMessage + " (x\(selectedQuantity))" : baseMessage
    }
}
