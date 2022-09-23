import Foundation

public protocol Model: Codable {
}

public extension Encodable {
    var prettyJSON: String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(self),
              let string = String(data: data, encoding: .utf8)
        else { return "Error to encode value" }
        return string
    }
    
    var log: Self {
        print("[INFO] \(Self.Type.self) \(Date())\n\(prettyJSON)")
        return self
    }
}
