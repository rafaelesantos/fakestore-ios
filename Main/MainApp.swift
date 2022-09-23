import SwiftUI
import Domain

@main
struct MainApp: App {
    let httpClient = makeNetworkAdapter()
    var getProducts: GetProducts { makeRemoteGetProducts(httpClient: httpClient) }
    var getCategories: GetCategories { makeRemoteCategories(httpClient: httpClient) }
    var body: some Scene {
        WindowGroup {
            VStack(spacing: 0) {
                makeProductsView(getProducts: getProducts, getCategories: getCategories)
                makeTabBarView { print($0) }.frame(height: 63)
            }
        }
    }
}
