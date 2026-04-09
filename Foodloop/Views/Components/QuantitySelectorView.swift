//
//  QuantitySelectorView.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 15/07/2025.
//

import SwiftUI

struct QuantitySelectorView: View {
    @ObservedObject var viewModel: AddToCartViewModel
    
    var body: some View {
        VStack(spacing: 12) {
            Text("quantity")
                .font(.headline)
                .foregroundStyle(.primary)
            
            HStack(spacing: 20) {
                Button(action: {
                    viewModel.decreaseQuantity()
                }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(viewModel.canDecreaseQuantity ? .purpleLight : .purpleLight.opacity(0.3))
                }
                .disabled(!viewModel.canDecreaseQuantity)
                
                Text("\(viewModel.selectedQuantity)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                    .frame(minWidth: 40)
                
                Button(action: {
                    viewModel.increaseQuantity()
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title2)
                        .foregroundStyle(viewModel.canIncreaseQuantity ? .purpleLight : .purpleLight.opacity(0.3))
                }
                .disabled(!viewModel.canIncreaseQuantity)
            }
        }
        .frame(height: 80)
    }
}
