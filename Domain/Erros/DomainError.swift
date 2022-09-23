import Foundation

public enum DomainError: Error {
    case decodedError(type: Decodable.Type)
    case requestError(description: String)
}

extension DomainError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .decodedError(let decodedType): return "Error on decoded - \(decodedType.self)"
        case .requestError(let description): return "Error on request - \(description)"
        }
    }
    
    public var log: Self {
        print("[ERROR] \(Date())\n\(description)")
        return self
    }
}
