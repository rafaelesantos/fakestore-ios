//
//  Constants.swift
//  FakeStore
//
//  Created by Rafael Escaleira Ferreira dos Santos on 22/09/22.
//

import Foundation

struct Constants {
    static let baseURL = "https://fakestoreapi.com"
    
    static func getAllProductsURL(limit: Int = 20) -> URL {
        return URL(string: "\(baseURL)/products?limit=\(limit)")!
    }
    
    static func getProductURL(byID id: Int) -> URL {
        return URL(string: "\(baseURL)/products/\(id)")!
    }
    
    static func getAllProductCategoriesURL() -> URL {
        return URL(string: "\(baseURL)/products/categories")!
    }
    
    static func getProductCategoryDetailURL(byCategory category: String) -> URL {
        return URL(string: "\(baseURL)/products/category/\(category)")!
    }
}
