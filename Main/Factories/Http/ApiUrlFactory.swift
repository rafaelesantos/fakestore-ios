import Foundation

func makeApiUrl(path: HttpPath) -> URL {
    return URL(string: "\(Environment.variable(.apiBaseUrl))\(path.rawValue)")!
}
