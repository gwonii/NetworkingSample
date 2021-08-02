import Foundation
import Common

public protocol NetworkCancellable {
    func cancel()
}

extension URLSessionTask: NetworkCancellable { }

public protocol NetworkService {
    typealias CompletionHandler = (Result<Data?, NetworkError>) -> Void
    func request(urlRequest: URLRequest, completion: @escaping CompletionHandler) -> NetworkCancellable
}

public final class DefaultNetworkService: NetworkService {
    
    private let configuration: NetworkConfiguration
    private let sessionManager: URLSessionManager
    private let logger: NetworkLoggerManager = .shared
    
    init(configuration: NetworkConfiguration, sessionManager: URLSessionManager) {
        self.configuration = configuration
        self.sessionManager = sessionManager
    }
    
    public func request(urlRequest: URLRequest, completion: @escaping CompletionHandler) -> NetworkCancellable {
        let urlSessionTask = sessionManager.request(urlRequest) { data, response, requestError in
            if let requestError = requestError {
                var error: NetworkError
                if let response = response as? HTTPURLResponse {
                    error = .error(statusCode: response.statusCode, data: data)
                } else {
                    error = self.resolve(error: requestError)
                }
                self.logger.log(error: requestError)
                completion(.failure(error))
            } else {
                self.logger.log(level: .debug, responseData: data, response: response)
                completion(.success(data))
            }
        }
        self.logger.log(level: .debug, request: urlRequest)
        return urlSessionTask
    }
    
    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        case .cancelled: return .cancelled
        default: return .generic(error)
        }
    }
}
