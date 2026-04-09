//
//  ContentView.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 02/06/2025.
//

import SwiftUI
import SwiftData

struct FoodloopView: View {
    
    @StateObject private var cartViewModel = CartViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            
            Tab("Menu", systemImage: "fork.knife", value: 0) {
                MenuListView()
                    .environmentObject(cartViewModel)
            }
            
            Tab("Table", systemImage: "table.furniture.fill", value: 1) {
                TableView()
            }
            
            Tab("Orders", systemImage: "list.clipboard.fill", value: 2) {
                OrdersView()
            }
            
            Tab("Cart", systemImage: "bag.fill", value: 3) {
                CartView()
                    .environmentObject(cartViewModel)
            }
            .badge(cartViewModel.totalItems > 0 ? cartViewModel.totalItems : 0)
        }
        .tint(.purpleLight)
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("SwitchToCartTab"))) { _ in
            selectedTab = 3
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("SwitchToMenuTab"))) { _ in
            selectedTab = 0
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("SwitchToOrdersTab"))) { _ in
            selectedTab = 2
        }
    }
}
