//
//  Product.swift
//  FakeStore
//
//  Created by Rafael Escaleira Ferreira dos Santos on 22/09/22.
//

import Foundation

struct Product: Codable, Identifiable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: ProductRating
}

struct ProductRating: Codable {
    let rate: Double
    let count: Int
}
