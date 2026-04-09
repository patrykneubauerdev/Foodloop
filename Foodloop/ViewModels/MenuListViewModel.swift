//
//  MenuListViewModel.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 29/06/2025.
//

import Foundation
import SwiftUI

@MainActor
class MenuListViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var searchText = ""
    @Published var selectedFilter: FilterType = .all
    @Published var showFilterPicker = false
    @Published var showItems = false
    @Published var selectedProduct: Product?
    
    private var hasLoadedOnce = false
    private let productService = ProductService()
    
    enum FilterType: String, CaseIterable {
        case all = "filter-all"
        case bestseller = "filter-bestseller"
        case spicy = "filter-spicy"
        case vegan = "filter-vegan"
        
        var localizedTitle: String {
            return String(localized: LocalizedStringResource(stringLiteral: self.rawValue))
        }
        
        var icon: String {
            switch self {
            case .all: return "line.3.horizontal.decrease.circle"
            case .bestseller: return "crown"
            case .spicy: return "flame"
            case .vegan: return "leaf"
            }
        }
    }
    
    // MARK: - Computed Properties
    var filteredProducts: [Product] {
        var filteredProducts = products
      
        switch selectedFilter {
        case .all:
            break
        case .bestseller:
            filteredProducts = filteredProducts.filter { $0.isBestseller }
        case .spicy:
            filteredProducts = filteredProducts.filter { $0.isSpicy }
        case .vegan:
            filteredProducts = filteredProducts.filter { $0.isVegan }
        }
        
        if !searchText.isEmpty {
            filteredProducts = filteredProducts.filter { product in
                product.localizedImageName.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        return filteredProducts
    }
    
    var shouldShowEmptyState: Bool {
        return filteredProducts.isEmpty && (!searchText.isEmpty || selectedFilter != .all)
    }
    
    var emptyStateMessage: String {
        return searchText.isEmpty ?
            String(localized: "not-available-prod-in-category") :
            String(localized: "else-or-change-filter")
    }
    
    // MARK: - Methods
    func loadProductsIfNeeded() async {
        guard !hasLoadedOnce else { return }
        
        showItems = false
        await fetchProducts()
        hasLoadedOnce = true
        
        try? await Task.sleep(nanoseconds: 300_000_000)
        withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
            showItems = true
        }
    }
    
    func handleViewAppeared() {
        if !products.isEmpty && !showItems {
            withAnimation(.spring(response: 0.8, dampingFraction: 0.6)) {
                showItems = true
            }
        }
    }
    
    func selectFilter(_ filter: FilterType) {
        withAnimation(.easeInOut(duration: 0.2)) {
            selectedFilter = filter
        }
    }
    
    func toggleFilterPicker() {
        showFilterPicker.toggle()
    }
    
    func selectProduct(_ product: Product) {
        selectedProduct = product
    }
    
    // MARK: - Private Methods
    private func fetchProducts() async {
        isLoading = true
        errorMessage = nil
        
        do {
            products = try await ProductService.loadProducts()
        } catch {
            errorMessage = String(localized: "error-fetch-failed")
        }
        
        isLoading = false
    }
}
