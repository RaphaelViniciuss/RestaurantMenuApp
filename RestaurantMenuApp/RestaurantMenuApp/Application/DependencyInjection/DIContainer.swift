//
//  DIContainer.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 08/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import UIKit

final class DIContainer {

    static let shared = DIContainer(dataTransferService: AppDIContainer().service)

    private let dataTransferService: DataTransferService

    init(dataTransferService: DataTransferService) {
        self.dataTransferService = dataTransferService
    }

    // MARK: - Repositories
    func makeRestaurantRepository() -> RestaurantRepository {
        return DataRestaurantsRepository(service: dataTransferService)
    }

    // MARK: - Use Cases
    func makeFetchRestaurantUseCase() -> FetchRestaurantUseCaseProtocol {
        return FetchRestaurantUseCase(restaurantRepository: makeRestaurantRepository())
    }

    // MARK: - View Models
    func makeHomeViewModel() -> HomeViewModelable {
        return HomeViewModel(fetchRestaurantUseCase: makeFetchRestaurantUseCase())
    }

    // MARK: - View Controllers
    func makeHomeViewController() -> HomeViewController {
        return .init(viewModel: makeHomeViewModel())
    }
}
