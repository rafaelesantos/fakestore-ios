import Foundation
import RefdsDataLayer

func makeEndpoint(path: HttpPath, method: HttpMethod) -> HttpEndpoint {
    let scheme = Environment.variable(.scheme)
    let host = Environment.variable(.host)
    return GenericEndpoint(scheme: HttpScheme(rawValue: scheme)!, host: host, path: path.rawValue, method: method)
}

struct GenericEndpoint: HttpEndpoint {
    var scheme: RefdsDataLayer.HttpScheme
    var host: String
    var path: String
    var method: RefdsDataLayer.HttpMethod
}
