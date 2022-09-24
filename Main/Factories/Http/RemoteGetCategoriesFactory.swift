import Foundation
import RefdsDataLayer
import Data
import Domain

func makeRemoteCategories(httpClient: HttpClient) -> GetCategories {
    return RemoteGetCategories(httpEndpoint: makeEndpoint(path: .categories, method: .get), httpClient: httpClient)
}
