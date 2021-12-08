//
//  Requestable.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 07/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import Foundation

public protocol Requestable {
    var path: String { get }
    var method: HTTPMethodType { get }
    var headerParamaters: [String: String] { get }
    var queryParameters: [String: Any] { get }
    var bodyParamaters: [String: Any] { get }

    func urlRequest(with networkConfig: NetworkConfigurable) throws -> URLRequest
}

public protocol ResponseRequestable: Requestable {
    associatedtype Response

    var responseDecoder: ResponseDecoder { get }
}

enum RequestableError: Error {
    case components
}

extension Requestable {

    func url(with config: NetworkConfigurable) throws -> URL {
        let endpoint = config.baseURL.absoluteString.appending(path)

        guard var urlComponents = URLComponents(string: endpoint) else {
            throw RequestableError.components
        }

        var urlQueryItems = [URLQueryItem]()

        queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: "\($0.value)"))
        }

        config.queryParameters.forEach {
            urlQueryItems.append(URLQueryItem(name: $0.key, value: $0.value))
        }

        urlComponents.queryItems = !urlQueryItems.isEmpty ? urlQueryItems : nil

        guard let url = urlComponents.url else {
            throw RequestableError.components
        }

        return url
    }

    public func urlRequest(with config: NetworkConfigurable) throws -> URLRequest {
        let url = try url(with: config)
        var urlRequest = URLRequest(url: url)
        var allHeaders: [String: String] = config.headers
        headerParamaters.forEach { allHeaders.updateValue($1, forKey: $0) }

        if !bodyParamaters.isEmpty {
            urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: bodyParamaters)
        }

        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = allHeaders
        return urlRequest
    }
}
