//
//  EndpointsAPI.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 08/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import Foundation

struct EndpointsAPI {

    static func getRestaurant(with requestDTO: RestaurantRequestDTO) -> Endpoint<RestaurantResponseDTO> {
        return .init(path: "restaurant/\(requestDTO.id)", method: .get)
    }
}
