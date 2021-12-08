//
//  NetworkService.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 07/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import Foundation

public protocol NetworkServiceProtocol {
    typealias CompletionHandler = (Result<Data?, NetworkError>) -> Void
    func request(endpoint: Requestable, completion: @escaping CompletionHandler) -> URLSessionTask?
}

public final class NetworkService: NetworkServiceProtocol {

    private let config: NetworkConfigurable
    private let sessionManager: NetworkSessionManagerProtocol
    private let logger: NetworkLoggerProtocol

    init(config: NetworkConfigurable,
         sessionManager: NetworkSessionManager = NetworkSessionManager(),
         logger: NetworkLogger = NetworkLogger()) {
        self.sessionManager = sessionManager
        self.config = config
        self.logger = logger
    }

    private func request(request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionTask {

        let sessionDataTask = sessionManager.request(request) { data, response, requestError in
            if let requestError = requestError {
                var error: NetworkError
                if let response = response as? HTTPURLResponse {
                    error = .error(statusCode: response.statusCode, data: data)
                } else {
                    error = self.resolve(error: requestError)
                }
                self.logger.log(error: error)
                completion(.failure(error))
            } else {
                self.logger.log(responseData: data, response: response)
                completion(.success(data))
            }
        }

        logger.log(request: request)
        return sessionDataTask
    }

    private func resolve(error: Error) -> NetworkError {
        let code = URLError.Code(rawValue: (error as NSError).code)

        switch code {
        case .notConnectedToInternet: return .notConnected
        default:                      return .generic(error)
        }
    }

    public func request(endpoint: Requestable, completion: @escaping CompletionHandler) -> URLSessionTask? {
        do {
            let urlRequest = try endpoint.urlRequest(with: config)
            return request(request: urlRequest, completion: completion)
        } catch {
            completion(.failure(.generic(error)))
            return nil
        }
    }
}
