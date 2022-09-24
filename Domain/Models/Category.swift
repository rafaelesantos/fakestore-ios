import Foundation
import RefdsUI
import RefdsDomainLayer

public struct Category: DomainModel, TagModel {
    public var label: String
    public var isRemovable: Bool = false
    public var isRemoved: Bool = false
    public var isSelected: Bool = false
    public var id: UUID = UUID()
    
    public init(label: String) {
        self.label = label
    }
}
