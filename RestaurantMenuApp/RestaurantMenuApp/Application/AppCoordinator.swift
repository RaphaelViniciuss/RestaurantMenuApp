//
//  AppCoordinator.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 07/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import UIKit

final class AppCoordinator: Coordinator {
    private let window: UIWindow

    /// Child coordinators from app coordinator
    private var childCoordinators = [Coordinator]()

    /// Root navigation controller
    private let navigationController: UINavigationController

    init(window: UIWindow) {
        self.window = window
        navigationController = UINavigationController()
        self.window.rootViewController = navigationController
    }

    func start() {
        let coordinator = HomeCoordinator(navigation: navigationController)
        coordinate(to: coordinator)
    }
}
