//
//  CartItemImageView.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 15/07/2025.
//

import SwiftUI

struct CartItemImageView: View {
    let product: Product
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .frame(width: 120, height: 150)
            
            Rectangle()
                .fill(Color.white)
                .frame(width: 20, height: 150)
                .offset(x: 50)
            
            Image(product.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 95, height: 85)
        }
        .clipped()
        .shadow(color: .black.opacity(0.1), radius: 6, x: 2, y: 0)
    }
}
