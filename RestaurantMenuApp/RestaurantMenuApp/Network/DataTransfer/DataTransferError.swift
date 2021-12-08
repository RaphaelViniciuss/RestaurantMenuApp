//
//  DataTransferError.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 07/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import Foundation
import os

public enum DataTransferError: Error {
    case noResponse
    case parsing(Error)
    case networkFailure(NetworkError)
    case resolvedNetworkFailure(Error)
}

// MARK: Resolver
public protocol DataTransferErrorResolverProtocol {
    func resolve(error: NetworkError) -> Error
}

public class DataTransferErrorResolver: DataTransferErrorResolverProtocol {

    public init() { }

    public func resolve(error: NetworkError) -> Error {
        return error
    }
}

// MARK: Logger
public protocol DataTransferErrorLoggerProtocol {
    func log(error: Error)
}

public final class DataTransferErrorLogger: DataTransferErrorLoggerProtocol {

    public init() { }

    public func log(error: Error) {
        os_log(.debug, "::[DataTransfer]:: Error: %@", error.localizedDescription)
    }
}
