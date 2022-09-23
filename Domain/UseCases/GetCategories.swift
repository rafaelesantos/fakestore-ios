import Foundation

public protocol GetCategories {
    typealias Result = Swift.Result<[Category], DomainError>
    func getCategories() async -> Result
}
