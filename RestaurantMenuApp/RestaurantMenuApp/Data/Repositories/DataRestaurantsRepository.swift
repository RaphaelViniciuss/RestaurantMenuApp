//
//  DataRestaurantsRepository.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 08/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import Foundation

final class DataRestaurantsRepository {
    private let service: DataTransferService

    init(service: DataTransferService) {
        self.service = service
    }
}

extension DataRestaurantsRepository: RestaurantRepository {

    func fetchRestaurant(id: String,
                         completion: @escaping (Result<Restaurant, Error>) -> Void) -> URLSessionTask? {
        let requestDTO = RestaurantRequestDTO(id: id)
        let endpoint = EndpointsAPI.getRestaurant(with: requestDTO)

        return service.request(with: endpoint) { result in
            switch result {
            case .success(let responseDTO):
                completion(.success(responseDTO.toDomain()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
