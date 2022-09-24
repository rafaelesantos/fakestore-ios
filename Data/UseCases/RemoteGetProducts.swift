import Foundation
import Domain
import RefdsDataLayer

public class RemoteGetProducts: GetProducts, HttpRequest {
    public typealias Response = [Product]
    public var httpClient: RefdsDataLayer.HttpClient
    public var httpEndpoint: RefdsDataLayer.HttpEndpoint
    
    public init(httpEndpoint: RefdsDataLayer.HttpEndpoint, httpClient: RefdsDataLayer.HttpClient) {
        self.httpClient = httpClient
        self.httpEndpoint = httpEndpoint
    }
    
    public func getProducts(limit: Int, sort: Sort) async -> GetProducts.Result {
        let result = await httpClient.request(self)
        switch result {
        case .success(let response): response.logger.console(); return .success(response)
        case .failure(let httpError): return .failure(.requestError(error: httpError))
        }
    }
}
