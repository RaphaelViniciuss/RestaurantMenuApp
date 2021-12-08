//
//  FetchRestaurantUseCase.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 08/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import Foundation

protocol FetchRestaurantUseCaseProtocol {
    func execute(id: String, completion: @escaping (Result<Restaurant, Error>) -> Void)
}

final class FetchRestaurantUseCase: FetchRestaurantUseCaseProtocol {

    private let restaurantRepository: RestaurantRepository

    init(restaurantRepository: RestaurantRepository) {
        self.restaurantRepository = restaurantRepository
    }

    func execute(id: String, completion: @escaping (Result<Restaurant, Error>) -> Void) {
        restaurantRepository.fetchRestaurant(id: id, completion: { result in
            completion(result)
        })
    }
}
