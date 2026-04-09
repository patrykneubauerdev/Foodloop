//
//  FoodloopApp.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 02/06/2025.
//

import SwiftUI

@main
struct FoodloopApp: App {
    
    
    init() {
           UIRefreshControl.appearance().tintColor = UIColor(Color.purpleLight)
       }
    
    var body: some Scene {
        WindowGroup {
            FoodloopView()
                .modelContainer(for: [Order.self, OrderItem.self])
        }
    }
}

#Preview {
    FoodloopView()
        .modelContainer(for: [Order.self, OrderItem.self], inMemory: true)
}
