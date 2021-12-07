//
//  HomeViewController.swift
//  RestaurantMenuApp
//
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import UIKit

protocol HomeViewControllerDelegate: AnyObject { }

final class HomeViewController: UIViewController {

    // MARK: Private Properties
    private let viewModel: HomeViewModelable

    // MARK: Public Properties
    weak var delegate: HomeViewControllerDelegate?

    // MARK: Initialization
    init(viewModel: HomeViewModelable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
}
