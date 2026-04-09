//
//  TableViewModel.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 18/07/2025.
//

import SwiftUI
import Foundation


class TableViewModel: ObservableObject {
    static let shared = TableViewModel()
    
    @Published var selectedTableNumber: Int = 1
    
    let availableTableNumbers = Array(1...99)
    
    private init() {}
    
    func updateTableNumber(_ number: Int) {
        selectedTableNumber = number
    }
}
