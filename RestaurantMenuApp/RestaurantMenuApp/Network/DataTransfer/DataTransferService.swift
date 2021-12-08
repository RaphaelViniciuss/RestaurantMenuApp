//
//  DataTransferService.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 07/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import Foundation

public protocol DataTransferServiceProtocol {
    typealias CompletionHandler<T> = (Result<T, DataTransferError>) -> Void

    @discardableResult
    func request<T: Decodable, E: ResponseRequestable>(with endpoint: E, completion: @escaping CompletionHandler<T>) -> URLSessionTask? where E.Response == T

    @discardableResult
    func request<E: ResponseRequestable>(with endpoint: E, completion: @escaping CompletionHandler<Void>) -> URLSessionTask? where E.Response == Void
}

public final class DataTransferService: DataTransferServiceProtocol {

    private let networkService: NetworkService
    private let errorResolver: DataTransferErrorResolverProtocol
    private let errorLogger: DataTransferErrorLoggerProtocol

    public init(with networkService: NetworkService,
                errorResolver: DataTransferErrorResolver = DataTransferErrorResolver(),
                errorLogger: DataTransferErrorLogger = DataTransferErrorLogger()) {
        self.networkService = networkService
        self.errorResolver = errorResolver
        self.errorLogger = errorLogger
    }

    public func request<T: Decodable, E: ResponseRequestable>(with endpoint: E, completion: @escaping CompletionHandler<T>) -> URLSessionTask? where E.Response == T {

        return self.networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success(let data):
                let result: Result<T, DataTransferError> = self.decode(data: data, decoder: endpoint.responseDecoder)
                DispatchQueue.main.async { return completion(result) }
            case .failure(let error):
                self.errorLogger.log(error: error)
                let error = self.resolve(networkError: error)
                DispatchQueue.main.async { return completion(.failure(error)) }
            }
        }
    }

    public func request<E>(with endpoint: E, completion: @escaping CompletionHandler<Void>) -> URLSessionTask? where E : ResponseRequestable, E.Response == Void {
        return self.networkService.request(endpoint: endpoint) { result in
            switch result {
            case .success:
                DispatchQueue.main.async { return completion(.success(())) }
            case .failure(let error):
                self.errorLogger.log(error: error)
                let error = self.resolve(networkError: error)
                DispatchQueue.main.async { return completion(.failure(error)) }
            }
        }
    }

    private func decode<T: Decodable>(data: Data?, decoder: ResponseDecoder) -> Result<T, DataTransferError> {
        do {
            guard let data = data else { return .failure(.noResponse) }
            let result: T = try decoder.decode(data)
            return .success(result)
        } catch {
            self.errorLogger.log(error: error)
            return .failure(.parsing(error))
        }
    }

    private func resolve(networkError error: NetworkError) -> DataTransferError {
        let resolvedError = self.errorResolver.resolve(error: error)
        return resolvedError is NetworkError ? .networkFailure(error) : .resolvedNetworkFailure(resolvedError)
    }
}
