//
//  Products.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 10/06/2025.
//

import Foundation

struct Product: Identifiable, Codable {
    
    let id: Int
    let imageName: String
    let price: Double
    let description: String
    let isVegan: Bool
    let isSpicy: Bool
    let isBestseller: Bool
    
    
    var localizedImageName: String {
        String(localized: LocalizedStringResource(stringLiteral: imageName))
    }
    
    var localizedDescription: String {
        String(localized: LocalizedStringResource(stringLiteral: description))
    }
}

