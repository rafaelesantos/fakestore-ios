import SwiftUI
import UI
import Domain
import State

@MainActor func makeProductsView(getProducts: GetProducts, getCategories: GetCategories) -> some View {
    let store = Store(getProducts: getProducts, getCategories: getCategories)
    return ProductsView().environmentObject(store)
}
