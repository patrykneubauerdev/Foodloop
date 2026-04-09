//
//  CheckoutView.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 09/08/2025.
//

import Foundation
import SwiftUI
import SwiftData
 
struct CheckoutView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @EnvironmentObject var cartViewModel: CartViewModel
    @EnvironmentObject var tableViewModel: TableViewModel
    @StateObject private var checkoutViewModel = CheckoutViewModel()
 
    @State private var showConfirmation = false
    @State private var showError = false
 
    var body: some View {
        NavigationView {
            ZStack {
                Color.boneBackground
                    .ignoresSafeArea()
 
                if !showConfirmation && !showError {
                    processingView
                        .transition(.opacity)
                }
 
                if let order = checkoutViewModel.order, showConfirmation {
                    orderConfirmationView(order: order)
                        .transition(.opacity)
                }
 
                if let errorMessage = checkoutViewModel.errorMessage, showError {
                    errorView(message: errorMessage)
                        .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.55), value: showConfirmation)
            .animation(.easeInOut(duration: 0.55), value: showError)
            .navigationBarHidden(true)
        }
        .interactiveDismissDisabled(true)
        .task {
            await runCheckout()
        }
    }
 
    // MARK: - Checkout Logic
 
    @MainActor
    private func runCheckout() async {
        await checkoutViewModel.processCheckout(
            cartItems: cartViewModel.items,
            tableNumber: tableViewModel.selectedTableNumber,
            modelContext: modelContext
        )
        withAnimation(.easeInOut(duration: 0.55)) {
            if checkoutViewModel.order != nil {
                showConfirmation = true
            } else {
                showError = true
            }
        }
    }
 
    // MARK: - Processing View
 
    private var processingView: some View {
        VStack(spacing: 32) {
            Spacer()
            AnimatedLoaderView()
            VStack(spacing: 12) {
                Text("processing-order")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
 
                Text("please-wait-moment")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
        }
        .padding(.horizontal, 32)
    }
 
    // MARK: - Order Confirmation View
 
    private func orderConfirmationView(order: Order) -> some View {
        VStack(spacing: 0) {
            VStack(spacing: 16) {
                SuccessLoaderView()
                    .scaleEffect(showConfirmation ? 1.0 : 0.5)
                    .animation(.spring(response: 0.6, dampingFraction: 0.7).delay(0.2), value: showConfirmation)
 
                Text("order-confirmed")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundStyle(.primary)
                    .opacity(showConfirmation ? 1 : 0)
                    .animation(.easeOut(duration: 0.4).delay(0.3), value: showConfirmation)
 
                Text("order-number-colon \(order.orderNumber)")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.purpleLight)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.purpleLight.opacity(0.1))
                            .stroke(Color.purpleLight.opacity(0.3), lineWidth: 1)
                    )
                    .opacity(showConfirmation ? 1 : 0)
                    .animation(.easeOut(duration: 0.4).delay(0.4), value: showConfirmation)
            }
            .padding(.top, 32)
            .padding(.bottom, 24)
            .padding(.horizontal, 16)
            .frame(maxWidth: .infinity)
 
            Divider()
                .opacity(showConfirmation ? 1 : 0)
                .animation(.easeOut(duration: 0.4).delay(0.45), value: showConfirmation)
 
            ScrollView {
                VStack(spacing: 16) {
                    OrderDetailsCard(order: order)
                        .opacity(showConfirmation ? 1 : 0)
                        .offset(y: showConfirmation ? 0 : 12)
                        .animation(.easeOut(duration: 0.4).delay(0.5), value: showConfirmation)
 
                    OrderItemsCard(items: order.items)
                        .opacity(showConfirmation ? 1 : 0)
                        .offset(y: showConfirmation ? 0 : 12)
                        .animation(.easeOut(duration: 0.4).delay(0.6), value: showConfirmation)
                }
                .padding(.horizontal, 16)
                .padding(.top, 20)
                .padding(.bottom, 16)
            }
            .scrollIndicators(.hidden)
        }
        .safeAreaInset(edge: .bottom) {
            VStack(spacing: 0) {
                Divider()
                Button(action: {
                    cartViewModel.clearCart()
                    dismiss()
                    NotificationCenter.default.post(name: NSNotification.Name("SwitchToOrdersTab"), object: nil)
                    NotificationCenter.default.post(name: NSNotification.Name("ScrollOrdersToTop"), object: nil)
                }) {
                    Text("go-to-order")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(.purpleLight)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 16)
            }
            .background(Color.boneBackground)
            .ignoresSafeArea(edges: .bottom)
            .opacity(showConfirmation ? 1 : 0)
            .animation(.easeOut(duration: 0.4).delay(0.7), value: showConfirmation)
        }
    }
 
    // MARK: - Error View
 
    private func errorView(message: String) -> some View {
        VStack(spacing: 24) {
            Spacer()
 
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 48))
                .foregroundStyle(.red)
 
            VStack(spacing: 12) {
                Text("checkout-error")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
 
                Text(message)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
 
            Button(action: {
                showError = false
                Task { await runCheckout() }
            }) {
                Text("try-again")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(.purpleLight)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
            .padding(.horizontal, 32)
 
            Spacer()
        }
        .padding(.horizontal, 32)
    }
}
 
#Preview {
    CheckoutView()
        .environmentObject(CartViewModel())
        .environmentObject(TableViewModel.shared)
        .modelContainer(for: Order.self, inMemory: true)
}
