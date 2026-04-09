//
//  ProductBadgesView.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 15/07/2025.
//

import SwiftUI

struct ProductBadgesView: View {
    let product: Product
    
    var body: some View {
        HStack(spacing: 8) {
            if product.isBestseller {
                ProductBadge(icon: "crown", text: "filter-bestseller", color: .orange)
            }
            if product.isSpicy {
                ProductBadge(icon: "flame", text: "filter-spicy", color: .red)
            }
            if product.isVegan {
                ProductBadge(icon: "leaf", text: "filter-vegan", color: .green)
            }
        }
    }
}


struct ProductBadge: View {
    let icon: String
    let text: LocalizedStringKey
    let color: Color
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 12, weight: .medium))
            Text(text)
                .font(.caption)
                .fontWeight(.medium)
        }
        .foregroundStyle(color)
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(color.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
