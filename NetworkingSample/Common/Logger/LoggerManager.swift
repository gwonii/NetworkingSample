import Foundation
import SwiftyBeaver

protocol LoggerManager {
    func log(level: SwiftyBeaver.Level, message: String)
}

public class BaseLoggerManager: LoggerManager {
    public typealias Logger = SwiftyBeaver

    public static var baseInfo: String { "file: \(#file), function: \(#function), line: \(#line)" }
    init() { fatalError("Subclasses need to implement the initialize") }
    
    public func log(level: Logger.Level, message: String) {
        switch level {
            case .verbose:
                Logger.verbose("\(Self.baseInfo): \(message)")
            case .error:
                Logger.error("\(Self.baseInfo): \(message)")
            case .warning:
                Logger.warning("\(Self.baseInfo): \(message)")
            case .debug:
                Logger.debug("\(Self.baseInfo): \(message)")
            case .info:
                Logger.info("\(Self.baseInfo): \(message)")
        }
    }
}


