import Foundation
import Data
import Domain

func makeRemoteCategories(httpClient: HttpGetClient) -> GetCategories {
    return RemoteGetCategories(url: makeApiUrl(path: .categories), httpClient: httpClient)
}
