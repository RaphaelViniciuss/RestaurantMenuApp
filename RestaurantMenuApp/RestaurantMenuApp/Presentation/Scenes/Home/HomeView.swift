//
//  HomeView.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 08/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import UIKit

final class HomeView: UIView, SceneView {

    // MARK: Public properties
    var restaurantData: Restaurant? {
        didSet {
            restaurantLabel.text = restaurantData?.restaurantName ?? "RESTAURANT"
            menuLabel.text = restaurantData?.menus.first?.menuName ?? "MENU"
            menuSectionCollectionView.reloadData()
            menuSectionCollectionView.layoutIfNeeded()
            menuItemCollectionView.reloadData()
            menuItemCollectionView.layoutIfNeeded()
        }
    }

    // MARK: Metrics
    private struct Metrics {
        struct Divider {
            static let topSpacing: CGFloat = 20
            static let ySpacing: CGFloat = 30
            static let heightSize: CGFloat = 1
        }

        struct Label {
            static let topSpacing: CGFloat = 30
        }

        struct MenuSection {
            static let heightSize: CGFloat = 50
        }

        struct MenuItem {
            static let minimumInteritemSpacing: CGFloat = 20
            static let minimumLineSpacing: CGFloat = 20
            static let insetsSpacing: CGFloat = 10
            static let topSpacing: CGFloat = 20
            static let heightSize: CGFloat = 50
        }
    }

    // MARK: Views
    private lazy var restaurantLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 20.0)
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.09, green: 0.09, blue: 0.09, alpha: 1.00)
        label.numberOfLines = .zero
        return label
    }()

    private lazy var dividerTitle: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
        return view
    }()

    private lazy var menuLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 20.0)
        label.textAlignment = .center
        label.textColor = UIColor(red: 0.13, green: 0.13, blue: 0.13, alpha: 1.00)
        label.numberOfLines = 1
        label.text = ""
        return label
    }()

    private lazy var dividerTopSectionMenu: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
        return view
    }()

    private var menuSectionCollectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        return layout
    }()

    lazy var menuSectionCollectionView: UICollectionView = {
        let layout = menuSectionCollectionViewFlowLayout
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.showsHorizontalScrollIndicator = false
        collection.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MenuSectionEmptyCell")
        collection.register(MenuSectionCell.self, forCellWithReuseIdentifier: "MenuSectionCell")
        collection.contentInsetAdjustmentBehavior = .always
        return collection
    }()

    private lazy var dividerBottomSectionMenu: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.93, green: 0.93, blue: 0.93, alpha: 1.00)
        return view
    }()

    private var menuitemCollectionViewFlowLayout: UICollectionViewFlowLayout = {
        let layout = MenuItemFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumInteritemSpacing = Metrics.MenuItem.minimumInteritemSpacing
        layout.minimumLineSpacing = Metrics.MenuItem.minimumLineSpacing
        layout.sectionInset = UIEdgeInsets(top: Metrics.MenuItem.insetsSpacing,
                                           left: Metrics.MenuItem.insetsSpacing,
                                           bottom: Metrics.MenuItem.insetsSpacing,
                                           right: Metrics.MenuItem.insetsSpacing)
        layout.headerReferenceSize = CGSize(width: .zero,
                                            height: Metrics.MenuItem.heightSize)
        return layout
    }()

    lazy var menuItemCollectionView: UICollectionView = {
        let layout = menuitemCollectionViewFlowLayout
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(MenuItemCell.self, forCellWithReuseIdentifier: "MenuItemCell")
        collection.register(MenuItemHeaderCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MenuItemHeaderCell")
        collection.register(UICollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MenuItemEmptyCell")
        collection.contentInsetAdjustmentBehavior = .always
        return collection
    }()

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: SceneView
    func setupView() {
        backgroundColor = .white
        buildSubviews()
        setupConstraints()
    }
    
    func buildSubviews() {
        addSubview(restaurantLabel)
        addSubview(dividerTitle)
        addSubview(menuLabel)
        addSubview(dividerTopSectionMenu)
        addSubview(menuSectionCollectionView)
        addSubview(dividerBottomSectionMenu)
        addSubview(menuItemCollectionView)
    }

    func setupConstraints() {
        restaurantLabel.layout(using: [
            restaurantLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            restaurantLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            restaurantLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

        dividerTitle.layout(using: [
            dividerTitle.topAnchor.constraint(equalTo: restaurantLabel.bottomAnchor, constant: Metrics.Divider.topSpacing),
            dividerTitle.leadingAnchor.constraint(equalTo: leadingAnchor),
            dividerTitle.trailingAnchor.constraint(equalTo: trailingAnchor),
            dividerTitle.heightAnchor.constraint(equalToConstant: Metrics.Divider.heightSize)
        ])

        menuLabel.layout(using: [
            menuLabel.topAnchor.constraint(equalTo: dividerTitle.bottomAnchor, constant: Metrics.Label.topSpacing),
            menuLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])

        dividerTopSectionMenu.layout(using: [
            dividerTopSectionMenu.topAnchor.constraint(equalTo: menuLabel.bottomAnchor, constant: Metrics.Divider.topSpacing),
            dividerTopSectionMenu.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Divider.ySpacing),
            dividerTopSectionMenu.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.Divider.ySpacing),
            dividerTopSectionMenu.heightAnchor.constraint(equalToConstant: Metrics.Divider.heightSize)
        ])

        menuSectionCollectionView.layout(using: [
            menuSectionCollectionView.topAnchor.constraint(equalTo: dividerTopSectionMenu.bottomAnchor),
            menuSectionCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuSectionCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuSectionCollectionView.heightAnchor.constraint(equalToConstant: Metrics.MenuSection.heightSize)
        ])

        dividerBottomSectionMenu.layout(using: [
            dividerBottomSectionMenu.topAnchor.constraint(equalTo: menuSectionCollectionView.bottomAnchor),
            dividerBottomSectionMenu.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Metrics.Divider.ySpacing),
            dividerBottomSectionMenu.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Metrics.Divider.ySpacing),
            dividerBottomSectionMenu.heightAnchor.constraint(equalToConstant: Metrics.Divider.heightSize)
        ])

        menuItemCollectionView.layout(using: [
            menuItemCollectionView.topAnchor.constraint(equalTo: dividerBottomSectionMenu.bottomAnchor, constant: Metrics.MenuItem.topSpacing),
            menuItemCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            menuItemCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            menuItemCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
