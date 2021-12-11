//
//  HomeViewModel.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 07/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import UIKit

protocol HomeViewModelable {
    var restaurant: Observable<Restaurant?> { get }

    func viewDidLoad()
}

final class HomeViewModel: HomeViewModelable {
    private let MOCK_ID = "4072702673999819"

    let restaurant: Observable<Restaurant?> = Observable(nil)

    private let fetchRestaurantUseCase: FetchRestaurantUseCaseProtocol

    // MARK: Initialization
    init(fetchRestaurantUseCase: FetchRestaurantUseCaseProtocol) {
        self.fetchRestaurantUseCase = fetchRestaurantUseCase
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func viewDidLoad() {
        fetchRestaurantUseCase.execute(id: MOCK_ID) { result in
            switch result {
            case .success(let data): self.restaurant.value = data
            case .failure(_): break
            }
        }
    }
}
