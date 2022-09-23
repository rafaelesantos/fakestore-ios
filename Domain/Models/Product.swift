import Foundation

public typealias Products = [Product]

public struct Product: Codable, Identifiable {
    public let id: Int
    public let title: String
    public let price: Double
    public let description: String
    public let category: String
    public let image: String
    public let rating: ProductRating
}

public struct ProductRating: Codable {
    public let rate: Double
    public let count: Int
}
