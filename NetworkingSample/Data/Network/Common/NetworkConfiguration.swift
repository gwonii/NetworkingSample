import Foundation

public protocol NetworkConfiguration {
    var baseURL: URL { get }
    var headers: [String: String] { get }
    var parameters: [String: String] { get }
}

public struct DefaultNetworkConfiguration: NetworkConfiguration {
    public let baseURL: URL
    public let headers: [String : String]
    public let parameters: [String: String]
    
    init(baseURL: URL, headers: [String: String], parameters: [String: String]) {
        self.baseURL = baseURL
        self.headers = headers
        self.parameters = parameters
    }
}
