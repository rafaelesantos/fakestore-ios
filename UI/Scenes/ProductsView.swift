import SwiftUI
import RefdsUI
import State
import Domain

public struct ProductsView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var store: Store
    @State private var colorSchemeIcon: Icon.Symbol = .moon
    
    static var userInterfaceStyleOverride : UIUserInterfaceStyle  {
        get { UIApplication.shared.firstKeyWindow?.overrideUserInterfaceStyle ?? .unspecified }
        set { UIApplication.shared.firstKeyWindow?.overrideUserInterfaceStyle = newValue }
    }
    
    @State private var isDarkMode = false {
        didSet {
            colorSchemeIcon = isDarkMode ? .sun : .moon
            Self.userInterfaceStyleOverride = isDarkMode ? .dark : .light
        }
    }
    
    @State private var selectedCategory: Domain.Category? {
        didSet { store.updateProducts(byCategory: selectedCategory) }
    }
    
    public init() {}
    
    public var body: some View {
        VStack(alignment: .leading, spacing: .medium) {
            HStack {
                Heading("Fake Store", style: .title1, alignment: .leading)
                Spacer()
                BarButton(colorSchemeIcon) {
                    isDarkMode.toggle()
                }
                .padding(.trailing)
            }
            .padding([.leading, .trailing], .medium)
            .padding(.top, .large)
            
            HorizontalScroll(itemWidth: .intrinsic, horizontalPadding: .medium) {
                categories
            }
            
            ScrollView {
                if store.productsByCategory.isEmpty {
                    Skeleton(.card())
                }
                products
                    .padding([.leading, .trailing], .medium)
            }
        }
        .onAppear { isDarkMode = colorScheme == .dark }
        .task {
            await store.loadCategories()
            await store.loadProducts()
            selectedCategory = store.categories.first
        }
    }
}

// MARK: - Products
extension ProductsView {
    private var products: some View {
        ForEach(store.productsByCategory, id: \.id) { product in
            Tile(product.title) {
                VStack(alignment: .leading, spacing: .medium) {
                    HStack {
                        Badge(product.category, style: .custom(labelColor: .blueNormal, outlineColor: .blueLight, backgroundColor: .blueLight))
                        Badge("R$ \(product.price)".replacingOccurrences(of: ".", with: ","), style: .custom(labelColor: .greenNormal, outlineColor: .greenLight, backgroundColor: .greenLight))
                    }
                    Text(product.description, lineLimit: 3)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding([.leading, .trailing, .bottom], .medium)
            }
            .lineLimit(2)
            .padding(.bottom, store.productsByCategory.last?.id == product.id ? .large : 0)
        }
    }
}

// MARK: - Categories
extension ProductsView {
    private var categories: some View {
        ForEach(store.categories) { category in
            Tag(category.label, isSelected: category == selectedCategory) {
                selectedCategory = category
            }
        }
    }
}
