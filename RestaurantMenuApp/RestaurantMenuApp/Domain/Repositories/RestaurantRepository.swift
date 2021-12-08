//
//  RestaurantRepository.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 08/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import Foundation

protocol RestaurantRepository {
    @discardableResult
    func fetchRestaurant(id: String, completion: @escaping (Result<Restaurant, Error>) -> Void) -> URLSessionTask?
}
