//
//  ContentView.swift
//  FakeStore
//
//  Created by Rafael Escaleira Ferreira dos Santos on 22/09/22.
//

import SwiftUI
import RefdsUI

struct ContentView: View {
    static var userInterfaceStyleOverride : UIUserInterfaceStyle  {
        get { UIApplication.shared.firstKeyWindow?.overrideUserInterfaceStyle ?? .unspecified }
        set { UIApplication.shared.firstKeyWindow?.overrideUserInterfaceStyle = newValue }
    }
    
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var store: Store
    @State private var isFontLoaded = false
    @State private var colorSchemeIcon: Icon.Symbol = .moon
    
    @State private var isDarkMode = false {
        didSet {
            colorSchemeIcon = isDarkMode ? .sun : .moon
            Self.userInterfaceStyleOverride = isDarkMode ? .dark : .light
        }
    }
    
    @State private var selectedCategory: Category? {
        didSet { store.updateProducts(byCategory: selectedCategory) }
    }
    
    var body: some View {
        productsView
    }
    
    private var productsView: some View {
        VStack(alignment: .leading, spacing: .medium) {
            if isFontLoaded {
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
                        ProgressView()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(.xxxLarge)
                    }
                    products
                        .padding([.leading, .trailing], .medium)
                }
            }
        }
        .onAppear {
            isFontLoaded = true
            isDarkMode = colorScheme == .dark
        }
        .task {
            try? await store.getAllCategories()
            try? await store.getAllProducts()
            selectedCategory = store.categories.first
        }
    }
    
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
    
    private var categories: some View {
        ForEach(store.categories) { category in
            Tag(category.label, isSelected: category == selectedCategory) {
                selectedCategory = category
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(Store())
    }
}
