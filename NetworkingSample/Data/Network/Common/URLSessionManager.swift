import Foundation

public protocol URLSessionManager {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void
    func request(_ request: URLRequest, completion: @escaping CompletionHandler) -> NetworkCancellable
}

public final class DefaultURLSessionManager: URLSessionManager {
    public init() {}
    public func request(_ request: URLRequest,
                        completion: @escaping CompletionHandler) -> NetworkCancellable {
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
        return task
    }
}
