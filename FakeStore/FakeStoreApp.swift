//
//  FakeStoreApp.swift
//  FakeStore
//
//  Created by Rafael Escaleira Ferreira dos Santos on 22/09/22.
//

import SwiftUI
import RefdsUI

@main
struct FakeStoreApp: App {
    @State private var tabIndex: Int = 0
    
    var body: some Scene {
        WindowGroup {
            VStack(spacing: 0) {
                if tabIndex == 0 {
                    ContentView().environmentObject(Store())
                }
                tabBarView
                    .frame(height: 60)
            }
        }
    }
    
    private var tabBarView: some View {
        TabBar(
            tab: TabBarItemModel(name: "Products", icon: .promoCode, color: .blueNormal, selection: 0),
            tabs: [
                TabBarItemModel(name: "Products", icon: .promoCode, color: .blueNormal, selection: 0)
            ],
            selectedTabIndex: $tabIndex
        )
    }
}
