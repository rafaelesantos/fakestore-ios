import Foundation

public final class Environment {
    public enum EnvironmentVariables: String {
        case apiBaseUrl = "https://fakestoreapi.com/"
    }
    
    public static func variable(_ key: EnvironmentVariables) -> String {
        return key.rawValue
    }
}
