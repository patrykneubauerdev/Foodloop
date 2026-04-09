//
//  CartSummaryView.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 15/07/2025.
//

import SwiftUI
 
struct CartSummaryView: View {
    @EnvironmentObject var cartViewModel: CartViewModel
    @StateObject private var tableViewModel = TableViewModel.shared
    @State private var showCheckout = false
    @State private var showCheckoutAlert = false
 
    var body: some View {
        VStack(spacing: 16) {
 
            HStack {
                Text("table-colon")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
 
                Picker("table", selection: $tableViewModel.selectedTableNumber) {
                    ForEach(1...99, id: \.self) { number in
                        Text("\(number)").tag(number)
                    }
                }
                .pickerStyle(.menu)
                .tint(.purpleLight)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.purpleLight.opacity(0.6), lineWidth: 1)
                )
 
                Spacer()
            }
            .padding(.horizontal, 16)
 
            Rectangle()
                .fill(.separator)
                .frame(height: 1)
                .padding(.horizontal, 16)
                .foregroundStyle(.purpleLight)
 
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("total")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
 
                    Text("\(String(localized: "products")) \(cartViewModel.totalItems)")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
 
                Spacer()
 
                Text("\(cartViewModel.totalPrice, specifier: "%.2f") zł")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.purpleLight)
            }
            .padding(.horizontal, 16)
            
            Button(action: {
                showCheckoutAlert = true
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "fork.knife")
                        .font(.system(size: 16, weight: .semibold))
                    
                    Text("checkout")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color.purpleLight)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .shadow(color: .purpleLight.opacity(0.3), radius: 8, x: 0, y: 4)
                .scaleEffect(showCheckoutAlert ? 0.95 : 1.0)
                .animation(.easeInOut(duration: 0.1), value: showCheckoutAlert)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 16)
            .disabled(cartViewModel.isEmpty)
            .alert("checkout-alert-title", isPresented: $showCheckoutAlert) {
                Button("checkout-alert-confirm", role: .cancel) {
                    showCheckout = true
                }
                Button("checkout-alert-cancel", role: .destructive) {
                }
            } message: {
                Text("checkout-alert-message")
            }
        }
        .padding(.top, 16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.ultraThinMaterial)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: -5)
        .sheet(isPresented: $showCheckout) {
            CheckoutView()
                .environmentObject(cartViewModel)
                .environmentObject(tableViewModel)
        }
    }
}
