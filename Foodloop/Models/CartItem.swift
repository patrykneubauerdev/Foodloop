//
//  CartItem.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 09/07/2025.
//

import Foundation
 
struct CartItem: Identifiable, Codable {
    var id = UUID()
    let product: Product
    var quantity: Int
    
    var totalPrice: Double {
        product.price * Double(quantity)
    }
}
