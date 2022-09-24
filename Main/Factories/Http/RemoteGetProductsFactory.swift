import Foundation
import RefdsDataLayer
import Data
import Domain

func makeRemoteGetProducts(httpClient: HttpClient) -> GetProducts {
    return RemoteGetProducts(httpEndpoint: makeEndpoint(path: .products, method: .get), httpClient: httpClient)
}
