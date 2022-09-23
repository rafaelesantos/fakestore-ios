import SwiftUI
import UI
import Domain
import State

@MainActor func makeTabBarView(completion: @escaping (Int) -> Void) -> some View {
    let tabs = Tab.allCases.map({ $0.tabItem })
    let selectedIndex: Int = tabs.first!.selection
    return TabBarView(selectedTab: tabs.first!, tabs: tabs, selectedIndex: selectedIndex, completion: completion)
}
