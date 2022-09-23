import Foundation
import Data

public class NetworkAdapter: HttpGetClient {
    private let session: URLSession
    
    public init(session: URLSession = .shared) {
        self.session = session
    }
    
    public func get(toURL url: URL) async -> HttpGetClient.Result {
        guard let result = try? await session.data(from: url) else { return .failure(.noConnectivity) }
        guard let statusCode = (result.1 as? HTTPURLResponse)?.statusCode else { return .failure(.noConnectivity) }
        return handle(statusCode: statusCode, withData: result.0)
    }
}

extension NetworkAdapter {
    private func handle(statusCode: Int, withData data: Data) -> Result<Data, HttpError> {
        switch statusCode {
        case 200...299: return .success(data)
        case 401: return .failure(.unauthorized)
        case 403: return .failure(.forbidden)
        case 400...499: return .failure(.badRequest)
        case 500...599: return .failure(.serverError)
        default: return .failure(.noConnectivity)
        }
    }
}
