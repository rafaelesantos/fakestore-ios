import Foundation
import Domain

public class RemoteGetProducts: GetProducts {
    private let url: URL
    private let httpClient: HttpGetClient
    
    public init(url: URL, httpClient: HttpGetClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func getProducts(limit: Int, sort: Sort) async -> GetProducts.Result {
        let url = url.appendingPathExtension("?limit=\(limit)&sort=\(sort.rawValue)")
        let result = await httpClient.get(toURL: url)
        switch result {
        case .success(let data):
            guard let decoded: [Product] = data.asModel() else { return .failure(.decodedError(type: [Product].self)) }
            return .success(decoded)
        case .failure(let httpError):
            return .failure(.requestError(description: httpError.description))
        }
    }
}
