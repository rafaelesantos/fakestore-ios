import Foundation

public protocol Model: Codable {
    var prettyJSON: String { get }
    func infoLog()
}

public extension Model {
    var prettyJSON: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(self),
              let string = String(data: data, encoding: .utf8)
        else { return "Error to encode value" }
        return string
    }
    
    func infoLog() {
        print("[INFO] \(Self.Type.self) \(Date())\n\(prettyJSON)")
    }
}
