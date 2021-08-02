import Foundation
import SwiftyBeaver

public class NetworkLoggerManager: BaseLoggerManager {
    
    public static let shared: NetworkLoggerManager = .init()
    
    private override init() { super.init() }
    
    public func log(level: Logger.Level = .error, error: Error) {
        self.log(level: level, message: "\(error)")
    }
    
    public func log(level: Logger.Level, responseData: Data?, response: URLResponse?) {
        self.log(level: level, message: "data: \(String(describing: responseData)), response: \(String(describing: response))")
    }
    
    public func log(level: Logger.Level, request: URLRequest) {
        self.log(level: level, message: "\(request)")
    }
}
