//
//  OrdersViewModel.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 09/08/2025.
//


import Foundation
import SwiftUI
import SwiftData
 
@MainActor
class OrdersViewModel: ObservableObject {
    @Published var orders: [Order] = []
 
    
    func loadOrders(from modelContext: ModelContext) {
        let descriptor = FetchDescriptor<Order>(
            sortBy: [SortDescriptor(\.createdAt, order: .reverse)]
        )
 
        do {
            orders = try modelContext.fetch(descriptor)
        } catch {
            print("Failed to load orders: \(error)")
        }
    }
}
