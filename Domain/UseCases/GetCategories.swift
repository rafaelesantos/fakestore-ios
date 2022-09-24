import Foundation
import RefdsDomainLayer

public protocol GetCategories {
    typealias Result = Swift.Result<[Category], DomainError>
    func getCategories() async -> Result
}
