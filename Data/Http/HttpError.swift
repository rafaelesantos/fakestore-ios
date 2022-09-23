import Foundation

public enum HttpError: Error {
    case noConnectivity
    case badRequest
    case serverError
    case unauthorized
    case forbidden
}

extension HttpError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .noConnectivity: return "No Connectivity"
        case .badRequest: return "Bad Request - The server cannot or will not process the request due to an apparent client error."
        case .serverError: return "Server Error - A generic error message, given when an unexpected condition was encountered and no more specific message is suitable."
        case .unauthorized: return "Unauthorized - Similar to 403 Forbidden, but specifically for use when authentication is required and has failed or has not yet been provided."
        case .forbidden: return "Forbidden - The request contained valid data and was understood by the server, but the server is refusing action."
        }
    }
}
