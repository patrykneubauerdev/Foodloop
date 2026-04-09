//
//  OrdersView.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 16/06/2025.
//

import SwiftUI
import SwiftData
 
struct OrdersView: View {
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = OrdersViewModel()
 
    @State private var hasAnimated = false
 
    var body: some View {
        NavigationView {
            ZStack {
                Color.boneBackground
                    .ignoresSafeArea()
 
                if viewModel.orders.isEmpty {
                    EmptyOrdersView(shouldAnimate: !hasAnimated)
                } else {
                    OrdersListView(orders: viewModel.orders) {
                        viewModel.loadOrders(from: modelContext)
                    }
                }
            }
            .navigationTitle(viewModel.orders.isEmpty ? "" : "orders")
            .navigationBarTitleDisplayMode(.large)
        }
        .onAppear {
            viewModel.loadOrders(from: modelContext)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                hasAnimated = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("SwitchToOrdersTab"))) { _ in
            viewModel.loadOrders(from: modelContext)
        }
    }
}
 
// MARK: - Empty Orders View
struct EmptyOrdersView: View {
    let shouldAnimate: Bool
 
    @State private var showContent = false
 
    var body: some View {
        VStack(spacing: 24) {
            Spacer()
 
            ZStack {
                Circle()
                    .fill(Color.purpleLight.opacity(0.1))
                    .frame(width: 100, height: 100)
 
                Image(systemName: "list.clipboard")
                    .font(.system(size: 40, weight: .medium))
                    .foregroundStyle(.purpleLight)
            }
            .scaleEffect(showContent ? 1.0 : 0.7)
            .opacity(showContent ? 1 : 0)
            .animation(
                .spring(response: 0.7, dampingFraction: 0.65).delay(0.1),
                value: showContent
            )
 
            VStack(spacing: 12) {
                Text("no-orders-yet")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                    .multilineTextAlignment(.center)
 
                Text("place-first-order")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }
            .offset(y: showContent ? 0 : 30)
            .opacity(showContent ? 1 : 0)
            .animation(
                .spring(response: 0.7, dampingFraction: 0.7).delay(0.25),
                value: showContent
            )
 
            Button(action: {
                NotificationCenter.default.post(name: NSNotification.Name("SwitchToMenuTab"), object: nil)
            }) {
                HStack(spacing: 8) {
                    Image(systemName: "fork.knife")
                        .font(.system(size: 16, weight: .medium))
 
                    Text("browse-menu")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
                .foregroundStyle(.white)
                .frame(width: 200, height: 50)
                .background(.purpleLight)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(color: .purpleLight.opacity(0.3), radius: 6, x: 0, y: 3)
            }
            .offset(y: showContent ? 0 : 40)
            .opacity(showContent ? 1 : 0)
            .animation(
                .spring(response: 0.7, dampingFraction: 0.7).delay(0.4),
                value: showContent
            )
 
            Spacer()
        }
        .padding(.horizontal, 32)
        .onAppear {
            if shouldAnimate {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                    showContent = true
                }
            } else {
                showContent = true
            }
        }
    }
}
 
// MARK: - Orders List View
struct OrdersListView: View {
    let orders: [Order]
    let onRefresh: () -> Void
 
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(orders) { order in
                        OrderCard(order: order)
                            .padding(.horizontal, 16)
                            .id(order.id)
                    }
                }
                .padding(.top, 8)
                .padding(.bottom, 100)
            }
            .scrollIndicators(.hidden)
            .refreshable {
                onRefresh()
            }
            .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("ScrollOrdersToTop"))) { _ in
                if let first = orders.first {
                    withAnimation {
                        proxy.scrollTo(first.id, anchor: .top)
                    }
                }
            }
        }
    }
}
 

 
#Preview {
    CartSummaryView()
        .environmentObject(CartViewModel())
}
