//
//  HomeCoordinator.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 07/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import UIKit

final class HomeCoordinator: Coordinator {

    let navigationController: UINavigationController

    init(navigation navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        navigationController.pushViewController(makeHomeViewController(), animated: true)
    }

    private func makeHomeViewController() -> UIViewController {
        let viewModel = HomeViewModel()
        let controller = HomeViewController(viewModel: viewModel)
        controller.delegate = self
        return controller
    }
}

extension HomeCoordinator: HomeViewControllerDelegate {
}
