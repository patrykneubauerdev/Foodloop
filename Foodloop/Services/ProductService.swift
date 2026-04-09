//
//  ProductService.swift
//  Foodloop
//
//  Created by Patryk Neubauer on 10/06/2025.
//

import Foundation

struct ProductService {
    
    static func loadProducts() async throws -> [Product] {
        guard let url = Bundle.main.url(forResource: "product", withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }
        
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([Product].self, from: data)
        
    }
}
