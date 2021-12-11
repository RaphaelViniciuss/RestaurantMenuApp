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
    public let queryParametersEncodable: Encodable?
    public let bodyParamaters: [String: Any]
    public let bodyParamatersEncodable: Encodable?
    public let responseDecoder: ResponseDecoder
    
    init(path: String,
         method: HTTPMethodType,
         headerParamaters: [String: String] = [:],
         queryParameters: [String: Any] = [:],
         queryParametersEncodable: Encodable? = nil,
         bodyParamaters: [String: Any] = [:],
         bodyParamatersEncodable: Encodable? = nil,
         responseDecoder: ResponseDecoder = JSONResponseDecoder()) {
        self.path = path
        self.method = method
        self.headerParamaters = headerParamaters
        self.queryParameters = queryParameters
        self.queryParametersEncodable = queryParametersEncodable
        self.bodyParamaters = bodyParamaters
        self.bodyParamatersEncodable = bodyParamatersEncodable
        self.responseDecoder = responseDecoder
    }
}
