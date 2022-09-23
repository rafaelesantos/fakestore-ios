import Foundation
import RefdsUI

enum Tab: Int, CaseIterable {
    case products = 0
    case cart = 1
    
    var tabItem: TabBarItemModel {
        switch self {
        case .products: return TabBarItemModel(name: "Products", icon: .shopping, color: .blueNormal, selection: self.rawValue)
        case .cart: return TabBarItemModel(name: "Cart", icon: .promoCode, color: .orangeNormal, selection: self.rawValue)
        }
    }
}
