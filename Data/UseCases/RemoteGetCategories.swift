import Foundation
import Domain

public class RemoteGetCategories: GetCategories {
    private let url: URL
    private let httpClient: HttpGetClient
    
    public init(url: URL, httpClient: HttpGetClient) {
        self.url = url
        self.httpClient = httpClient
    }
    
    public func getCategories() async -> GetCategories.Result {
        let result = await httpClient.get(toURL: url)
        switch result {
        case .success(let data):
            guard let decoded: [String] = data.asModel() else { return .failure(.decodedError(type: [Domain.Category].self).log) }
            return .success(decoded.map({ Domain.Category(label: $0) }).log)
        case .failure(let httpError):
            return .failure(.requestError(description: httpError.description).log)
        }
    }
}
