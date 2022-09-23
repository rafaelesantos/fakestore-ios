import Foundation
import Domain

@MainActor
public class Store: ObservableObject {
    @Published private var products: [Product] = []
    @Published public var productsByCategory: [Product] = []
    @Published public var categories: [Domain.Category] = []
    @Published public var domainError: DomainError?
    
    private let getProducts: GetProducts
    private let getCategories: GetCategories
    
    public init(getProducts: GetProducts, getCategories: GetCategories) {
        self.getProducts = getProducts
        self.getCategories = getCategories
    }
    
    public func loadProducts(limit: Int = 20, sort: Sort = .ascending) async {
        let result = await getProducts.getProducts(limit: limit, sort: sort)
        switch result {
        case .success(let products): self.products = products
        case .failure(let domainError): self.domainError = domainError
        }
    }
    
    public func updateProducts(byCategory category: Domain.Category?) {
        if let category = category {
            productsByCategory = products.filter({ $0.category.lowercased() == category.label.lowercased() || category.label.lowercased() == "all" })
        }
    }
    
    public func loadCategories() async {
        let result = await getCategories.getCategories()
        switch result {
        case .success(let categories):
            self.categories = categories
            self.categories.insert(Category(label: "all"), at: 0)
        case .failure(let domainError): self.domainError = domainError
        }
    }
}
