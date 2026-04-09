//
//  ProductListView.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 10/06/2025.
//

import SwiftUI

struct MenuListView: View {
    
    @StateObject private var viewModel = MenuListViewModel()
    @EnvironmentObject var cartViewModel: CartViewModel
    
    var body: some View {
        ZStack {
            NavigationStack {
                
                if viewModel.isLoading {
                    LoadingView()
                } else {
                    ProductListView(viewModel: viewModel)
                }
            }
            .navigationTitle("Menu")
            .confirmationDialog("Filter", isPresented: $viewModel.showFilterPicker) {
                FilterOptionsView(viewModel: viewModel)
            }
        }
        .task {
            await viewModel.loadProductsIfNeeded()
        }
        .sheet(item: $viewModel.selectedProduct) { product in
            AddToCartView(product: product)
                .environmentObject(cartViewModel)
        }
    }
}

// MARK: - Subviews
struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .scaleEffect(1.5)
                .progressViewStyle(CircularProgressViewStyle(tint: .purpleLight))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.boneBackground)
    }
}

struct ProductListView: View {
    @ObservedObject var viewModel: MenuListViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 14) {
                ForEach(Array(viewModel.filteredProducts.enumerated()), id: \.element.id) { index, product in
                    ProductRowView(product: product)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color.bone)
                        .cornerRadius(16)
                        .scaleEffect(viewModel.showItems ? 1.0 : 0.3)
                        .opacity(viewModel.showItems ? 1 : 0)
                        .offset(y: viewModel.showItems ? 0 : 100)
                        .animation(
                            .spring(response: 0.8, dampingFraction: 0.6, blendDuration: 0)
                            .delay(Double(index) * 0.15),
                            value: viewModel.showItems
                        )
                        .onTapGesture {
                            viewModel.selectProduct(product)
                        }
                }
                
                if viewModel.shouldShowEmptyState {
                    EmptyStateView(message: viewModel.emptyStateMessage,
                                 showItems: viewModel.showItems)
                }
            }
            .padding(.horizontal, 16)
            .padding(.top, 8)
        }
       
        .background(Color.boneBackground)
        .scrollIndicators(.hidden)
        .searchable(
            text: $viewModel.searchText,
            placement: .navigationBarDrawer(displayMode: .automatic),
            prompt: "search-products"
        )
        .toolbar {
            FilterToolbarButton(viewModel: viewModel)
        }
        .onAppear {
            viewModel.handleViewAppeared()
        }
    }
}

struct EmptyStateView: View {
    let message: String
    let showItems: Bool
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))
                .foregroundStyle(.purpleLight)
            
            Text("no-products-found")
                .font(.headline)
                .foregroundStyle(.purpleLight)
            
            Text(message)
                .font(.subheadline)
                .foregroundStyle(.purpleLight)
                .opacity(0.7)
        }
        .padding(.top, 170)
        .opacity(showItems ? 1 : 0)
        .animation(.easeInOut(duration: 0.3), value: showItems)
    }
}

struct FilterToolbarButton: View {
    @ObservedObject var viewModel: MenuListViewModel
    
    var body: some View {
        Button(action: viewModel.toggleFilterPicker) {
            HStack(spacing: 6) {
                Image(systemName: "arrow.up.arrow.down")
                    .font(.system(size: 16, weight: .medium))
                if viewModel.selectedFilter != .all {
                    Image(systemName: viewModel.selectedFilter.icon)
                        .font(.system(size: 14, weight: .medium))
                }
            }
        }
    }
}

struct FilterOptionsView: View {
    @ObservedObject var viewModel: MenuListViewModel
    
    var body: some View {
        ForEach(MenuListViewModel.FilterType.allCases, id: \.self) { filter in
            Button(action: {
                viewModel.selectFilter(filter)
            }) {
                HStack {
                    Image(systemName: filter.icon)
                    Text(filter.localizedTitle)
                }
            }
        }
    }
}

#Preview {
    MenuListView()
}
