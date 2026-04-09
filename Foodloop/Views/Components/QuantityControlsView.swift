//
//  QuantityControlsView.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 04/08/2025.
//

import SwiftUI

struct QuantityControlsView: View {
    @ObservedObject var viewModel: ProductDetailViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            Text("quantity")
                .font(.headline)
                .foregroundStyle(.primary)
            
            Spacer()
            
            HStack(spacing: 0) {
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        viewModel.decreaseQuantity()
                    }
                }) {
                    Image(systemName: "minus")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(viewModel.canDecreaseQuantity ? .purpleLight : .gray)
                        .frame(width: 44, height: 44)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.bone)
                        )
                }
                .disabled(!viewModel.canDecreaseQuantity)
                .buttonStyle(ScaleButtonStyle())
                
                Text("\(viewModel.selectedQuantity)")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                    .frame(width: 60)
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.1)) {
                        viewModel.increaseQuantity()
                    }
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundStyle(viewModel.canIncreaseQuantity ? .purpleLight : .gray)
                        .frame(width: 44, height: 44)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.bone)
                        )
                }
                .disabled(!viewModel.canIncreaseQuantity)
                .buttonStyle(ScaleButtonStyle())
            }
        }
        .padding(.horizontal, 16)
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}
