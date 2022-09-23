import Foundation
import Data
import Domain

func makeRemoteGetProducts(httpClient: HttpGetClient) -> GetProducts {
    return RemoteGetProducts(url: makeApiUrl(path: .products), httpClient: httpClient)
}
