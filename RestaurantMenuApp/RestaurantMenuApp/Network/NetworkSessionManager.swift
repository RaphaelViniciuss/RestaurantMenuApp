//
//  NetworkSessionManager.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 07/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import Foundation

public protocol NetworkSessionManagerProtocol {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    func request(_ request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionTask
}

public class NetworkSessionManager: NetworkSessionManagerProtocol {

    public init() {}

    public func request(_ request: URLRequest, completion: @escaping CompletionHandler) -> URLSessionTask {
        let task = URLSession.shared.dataTask(with: request, completionHandler: completion)
        task.resume()
        return task
    }
}
