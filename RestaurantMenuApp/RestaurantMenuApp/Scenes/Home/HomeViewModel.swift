//
//  HomeViewModel.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 07/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import UIKit

protocol HomeViewModelable { }

final class HomeViewModel: HomeViewModelable {

    // MARK: Initialization
    init() { }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
