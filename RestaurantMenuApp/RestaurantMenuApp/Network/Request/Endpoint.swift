//
//  Endpoint.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 07/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import Foundation

public class Endpoint<R>: ResponseRequestable {
    
    public typealias Response = R
    
    public let path: String
    public let method: HTTPMethodType
    public let headerParamaters: [String: String]
    public let queryParameters: [String: Any]
    public let bodyParamaters: [String: Any]
    public let responseDecoder: ResponseDecoder
    
    init(path: String,
         method: HTTPMethodType,
         headerParamaters: [String: String] = [:],
         queryParameters: [String: Any] = [:],
         bodyParamaters: [String: Any] = [:],
         responseDecoder: ResponseDecoder = JSONResponseDecoder()) {
        self.path = path
        self.method = method
        self.headerParamaters = headerParamaters
        self.queryParameters = queryParameters
        self.bodyParamaters = bodyParamaters
        self.responseDecoder = responseDecoder
    }
}
