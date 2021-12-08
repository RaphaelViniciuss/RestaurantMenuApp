//
//  NetworkLogger.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 07/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import Foundation
import os

public protocol NetworkLoggerProtocol {
    func log(request: URLRequest)
    func log(responseData data: Data?, response: URLResponse?)
    func log(error: Error)
}

public final class NetworkLogger: NetworkLoggerProtocol {

    public init() { }

    public func log(request: URLRequest) {

        var logDict: [String:String?] = [
            "request":request.url?.absoluteString,
            "headers":request.allHTTPHeaderFields?.description,
            "method":request.httpMethod?.description,
        ]

        if let httpBody = request.httpBody,
           let result = try? JSONSerialization.jsonObject(with: httpBody, options: []) as? [String: AnyObject] {
            logDict.updateValue(String(describing: result), forKey: "body")
        } else if let httpBody = request.httpBody,
                  let resultString = String(data: httpBody, encoding: .utf8) {
            logDict.updateValue(resultString, forKey: "body")
        }

        os_log(.debug, "::[Network]:: %@", logDict)
    }

    public func log(responseData data: Data?, response: URLResponse?) {
        guard let data = data else { return }
        if let dataDict = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            os_log(.debug, "::[Network]:: body: %@", String(describing: dataDict))
        }
    }

    public func log(error: Error) {
        os_log(.debug, "::[Network]:: error: %@", error.localizedDescription)
    }
}
