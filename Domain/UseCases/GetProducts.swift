import Foundation
import RefdsDomainLayer

public protocol GetProducts {
    typealias Result = Swift.Result<[Product], DomainError>
    func getProducts(limit: Int, sort: Sort) async -> Result
}
