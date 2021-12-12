//
//  DataRestaurantsRepositoryMock.swift
//  RestaurantMenuAppTests
//
//  Created by Raphael Vinicius on 11/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import Foundation
@testable import RestaurantMenuApp

class DataRestaurantsRepositoryMock: RestaurantRepository {

    var response: Restaurant?
    var error: Error?
    var isSuccess: Bool = true

    func fetchRestaurant(id: String, completion: @escaping (Result<Restaurant, Error>) -> Void) -> URLSessionTask? {
        if isSuccess, let response = response {
            completion(.success(response))
        } else {
            completion(.failure(error ?? DataTransferError.noResponse))
        }
        return nil
    }

}
