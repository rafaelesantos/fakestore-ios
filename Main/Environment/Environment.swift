import Foundation

public final class Environment {
    public enum EnvironmentVariables: String {
        case scheme = "https"
        case host = "fakestoreapi.com"
    }
    
    public static func variable(_ key: EnvironmentVariables) -> String {
        return key.rawValue
    }
}
