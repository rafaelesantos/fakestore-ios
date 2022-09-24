import Foundation
import Domain
import RefdsDataLayer

public class RemoteGetCategories: GetCategories, HttpRequest {
    public typealias Response = [String]
    public var httpClient: RefdsDataLayer.HttpClient
    public var httpEndpoint: RefdsDataLayer.HttpEndpoint
    
    public init(httpEndpoint: RefdsDataLayer.HttpEndpoint, httpClient: RefdsDataLayer.HttpClient) {
        self.httpClient = httpClient
        self.httpEndpoint = httpEndpoint
    }
    
    public func getCategories() async -> GetCategories.Result {
        let result = await httpClient.request(self)
        switch result {
        case .success(let response): return .success(response.map({ Domain.Category(label: $0) }))
        case .failure(let httpError): return .failure(.requestError(error: httpError))
        }
    }
}
