import Foundation

public protocol GetProducts {
    typealias Result = Swift.Result<[Product], DomainError>
    func getProducts(limit: Int, sort: Sort) async throws -> Result
}
