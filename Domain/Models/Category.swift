import Foundation

struct Category: Encodable {
    var label: String
    var isRemovable: Bool = false
    var isRemoved: Bool = false
    var isSelected: Bool = false
    var id: UUID = UUID()
}
