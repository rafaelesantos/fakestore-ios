import SwiftUI
import RefdsUI

public struct TabBarView: View {
    private var selectedTab: TabBarItemModel
    private var tabs: [TabBarItemModel]
    private var completion: ((Int) -> Void)?
    private var selectedIndex: Int = 0 {
        didSet {
            completion?(selectedIndex)
        }
    }
    
    public init(selectedTab: TabBarItemModel, tabs: [TabBarItemModel], selectedIndex: Int, completion: @escaping (Int) -> Void) {
        self.selectedTab = selectedTab
        self.tabs = tabs
        self.selectedIndex = selectedIndex
        self.completion = completion
    }
    
    public var body: some View {
        TabBar(tab: selectedTab, tabs: tabs, selectedIndex: selectedIndex, completion: completion!)
    }
}
