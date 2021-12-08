//
//  ResponseDecoder.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 07/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import Foundation

public protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

public class JSONResponseDecoder: ResponseDecoder {

    private let jsonDecoder = JSONDecoder()

    public init() { }

    public func decode<T: Decodable>(_ data: Data) throws -> T {
        return try jsonDecoder.decode(T.self, from: data)
    }
}

public class RawDataResponseDecoder: ResponseDecoder {

    public init() { }

    enum CodingKeys: String, CodingKey {
        case `default` = ""
    }

    public func decode<T: Decodable>(_ data: Data) throws -> T {
        guard T.self is Data.Type, let data = data as? T else {
            let context = DecodingError.Context(codingPath: [CodingKeys.default], debugDescription: "Expected Data type")
            throw Swift.DecodingError.typeMismatch(T.self, context)
        }

        return data
    }
}
