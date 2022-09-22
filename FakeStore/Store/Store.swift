//
//  Store.swift
//  FakeStore
//
//  Created by Rafael Escaleira Ferreira dos Santos on 22/09/22.
//

import Foundation

@MainActor
class Store: ObservableObject {
    @Published private var products: [Product] = []
    @Published var productsByCategory: [Product] = []
    @Published var categories: [Category] = []
    
    func getAllProducts(limit: Int = 20) async throws {
        let (data, response) = try await URLSession.shared.data(from: Constants.getAllProductsURL(limit: limit))
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else { throw NetworkError.invalidRequest }
        
        products = try JSONDecoder().decode([Product].self, from: data)
        productsByCategory = products
        products.infoLog()
    }
    
    func updateProducts(byCategory category: Category?) {
        if let category = category {
            productsByCategory = products.filter({ $0.category.lowercased() == category.label.lowercased() || category.label.lowercased() == "all" })
        }
    }
    
    func getAllCategories() async throws {
        let (data, response) = try await URLSession.shared.data(from: Constants.getAllProductCategoriesURL())
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200
        else { throw NetworkError.invalidRequest }
        
        var strings = try JSONDecoder().decode([String].self, from: data)
        strings.insert("all", at: 0)
        categories = strings.map({ Category(label: $0) })
        categories.infoLog()
    }
}
