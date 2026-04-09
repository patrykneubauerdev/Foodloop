//
//  Order.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 09/08/2025.
//

import Foundation
import SwiftData
import SwiftUI
 
// MARK: - Order Model
@Model
class Order {
    @Attribute(.unique) var id: String
    var orderNumber: String
    var tableNumber: Int
    var items: [OrderItem]
    var totalPrice: Double
    var createdAt: Date
    var estimatedDeliveryTime: Date
 
    init(id: String = UUID().uuidString,
         orderNumber: String,
         tableNumber: Int,
         items: [OrderItem],
         totalPrice: Double,
         createdAt: Date = Date(),
         estimatedDeliveryTime: Date = Date().addingTimeInterval(20 * 60)) {
        self.id = id
        self.orderNumber = orderNumber
        self.tableNumber = tableNumber
        self.items = items
        self.totalPrice = totalPrice
        self.createdAt = createdAt
        self.estimatedDeliveryTime = estimatedDeliveryTime
    }
}
 
// MARK: - Order Item Model
@Model
class OrderItem {
    var productId: Int
    var productName: String
    var productPrice: Double
    var quantity: Int
    var totalPrice: Double
 
    init(productId: Int, productName: String, productPrice: Double, quantity: Int) {
        self.productId = productId
        self.productName = productName
        self.productPrice = productPrice
        self.quantity = quantity
        self.totalPrice = productPrice * Double(quantity)
    }
}
 
 
// MARK: - Response Model
struct OrderResponse: Codable {
    let success: Bool
    let orderNumber: String
    let estimatedDeliveryMinutes: Int
}
