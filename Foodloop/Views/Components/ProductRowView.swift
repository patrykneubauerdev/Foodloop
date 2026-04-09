//
//  ProductRow.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 10/06/2025.
//

import SwiftUI

struct ProductRowView: View {
    
    
    let product: Product
    
    var body: some View {
        ZStack {
            
            
            HStack(spacing: 24) {
                Image(product.imageName)
                    .resizable()
                    .frame(width: 80, height: 80)
                    .clipShape(.circle)
                    .glassEffect()
                
                
                
                VStack(alignment: .leading, spacing: 8){
                    Text(product.localizedImageName)
                        .foregroundStyle(.primary)
                        .font(.title3)
                    Text("\(product.price, specifier: "%.2f") zł")
                        .foregroundStyle(.purpleLight)
                    
                }
                
                Spacer()
                
                
                VStack(spacing: 8) {
                    HStack(spacing: 8) {
                        if product.isVegan {
                            Image(systemName: "leaf.fill")
                                .foregroundStyle(.green)
                                .frame(width: 30, height: 30)
                                .glassEffect()
                        }
                        
                        if product.isSpicy {
                            Image(systemName: "flame.fill")
                                .foregroundStyle(.red)
                                .frame(width: 30, height: 30)
                                .glassEffect()
                        }
                    }
                    
                    if product.isBestseller {
                        Image(systemName: "crown.fill")
                            .foregroundStyle(.yellow)
                            .frame(width: 30, height: 30)
                            .glassEffect()
                    }
                }
                
                
                
                
                
            }
            .frame(height: 80)
            
            
            
            
        }
    }
}

#Preview {
    ProductRowView(product: Product.sampleProduct)
}
