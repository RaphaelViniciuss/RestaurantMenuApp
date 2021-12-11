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
    var isLoading: Observable<Bool> { get }

    func viewDidLoad()
}

final class HomeViewModel: HomeViewModelable {
    private let MOCK_ID = "4072702673999819"

    let restaurant: Observable<Restaurant?> = Observable(nil)
    let isLoading: Observable<Bool> = Observable(false)

    private let fetchRestaurantUseCase: FetchRestaurantUseCaseProtocol

    // MARK: Initialization
    init(fetchRestaurantUseCase: FetchRestaurantUseCaseProtocol) {
        self.fetchRestaurantUseCase = fetchRestaurantUseCase
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func viewDidLoad() {
        isLoading.value = true
        fetchRestaurantUseCase.execute(id: MOCK_ID) { [unowned self] result in
            self.isLoading.value = false
            switch result {
            case .success(let data): self.restaurant.value = data
            case .failure(_): break
            }
        }
    }
}
