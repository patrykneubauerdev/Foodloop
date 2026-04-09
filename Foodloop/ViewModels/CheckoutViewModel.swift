//
//  CheckoutViewModel.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 09/08/2025.
//

import Foundation
import SwiftUI
import SwiftData
 
@MainActor
class CheckoutViewModel: ObservableObject {
    @Published var isProcessing = false
    @Published var order: Order?
    @Published var errorMessage: String?
 
    private let orderService = OrderService.shared
 
    func processCheckout(cartItems: [CartItem], tableNumber: Int, modelContext: ModelContext) async {
        isProcessing = true
        errorMessage = nil
 
        let orderNumber = generateOrderNumber()
 
      
        let orderItems = cartItems.map { cartItem in
            OrderItem(
                productId: cartItem.product.id,
                productName: cartItem.product.localizedImageName,
                productPrice: cartItem.product.price,
                quantity: cartItem.quantity
            )
        }
 
     
        let newOrder = Order(
            orderNumber: orderNumber,
            tableNumber: tableNumber,
            items: orderItems,
            totalPrice: cartItems.reduce(0) { $0 + $1.totalPrice }
        )
 
        do {
            _ = try await orderService.submitOrder(newOrder)
 
          
            modelContext.insert(newOrder)
 
            do {
                try modelContext.save()
                print("Order saved to SwiftData successfully")
            } catch {
                print("SwiftData save error: \(error)")
            }
 
            order = newOrder
            print("Checkout completed successfully")
 
        } catch {
            print("Checkout error: \(error)")
            errorMessage = String(localized: "checkout-error")
        }
 
        isProcessing = false
    }
 
    private func generateOrderNumber() -> String {
        let timestamp = Int(Date().timeIntervalSince1970)
        let random = Int.random(in: 1000...9999)
        return "FL\(timestamp % 100000)\(random)"
    }
}
