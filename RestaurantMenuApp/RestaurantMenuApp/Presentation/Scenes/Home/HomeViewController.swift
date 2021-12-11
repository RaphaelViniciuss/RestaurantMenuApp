//
//  HomeViewController.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 07/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject { }

final class HomeViewController: UIViewController {

    // MARK: Private Properties
    private let viewModel: HomeViewModelable

    // MARK: Public Properties
    weak var coordinationDelegate: HomeViewControllerDelegate?

    var restaurant: Restaurant? {
        didSet {
            if let restaurant = restaurant {
                self.homeView.restaurantData = restaurant
            }
        }
    }

    lazy var homeView: HomeView = {
        let view = HomeView()
        view.menuSectionCollectionView.delegate = self
        view.menuSectionCollectionView.dataSource = self
        view.menuItemCollectionView.delegate = self
        view.menuItemCollectionView.dataSource = self
        return view
    }()

    var shouldHighlightOnScroll: Bool = true

    // MARK: Init
    init(viewModel: HomeViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    override func loadView() {
        view = homeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bindObservables()
        viewModel.viewDidLoad()
    }

    // MARK:  Observables
    private func bindObservables() {
        viewModel.restaurant.observe(on: self) { [weak self] data in
            guard let data = data else { return }
            self?.restaurant = data
        }
    }
}
