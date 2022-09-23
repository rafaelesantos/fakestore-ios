import SwiftUI
import RefdsUI
import Domain

@main
struct MainApp: App {
    let httpClient = makeNetworkAdapter()
    var getProducts: GetProducts { makeRemoteGetProducts(httpClient: httpClient) }
    var getCategories: GetCategories { makeRemoteCategories(httpClient: httpClient) }
    @State var selectedIndex: Int = 0
    
    init() { Font.registerRefdsUIFonts(isMono: true) }
    
    var body: some Scene {
        WindowGroup {
            VStack {
                if selectedIndex == 0 { makeProductsView(getProducts: getProducts, getCategories: getCategories) }
                else if selectedIndex == 1 {
                    ScrollView {
                        VStack(alignment: .leading, spacing: .medium) {
                            Skeleton(.list(rows: 3), animation: .default)
                            Skeleton(.image(height: 150), animation: .default)
                            Skeleton(.card(height: 200), animation: .default)
                            Skeleton(.button(), animation: .default)
                            Skeleton(.text(lines: 4), animation: .default)
                        }
                        .padding([.leading, .trailing], .medium)
                        .padding(.top, .large)
                        .padding(.bottom, 100)
                    }
                }
            }
            .frame(maxHeight: .infinity)
            .overlay {
                Spacer()
                makeTabBarView { selectedIndex = $0 }
            }
        }
    }
}
