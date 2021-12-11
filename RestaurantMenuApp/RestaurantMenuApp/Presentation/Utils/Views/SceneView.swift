//
//  SceneView.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 08/12/21.
//  Copyright © 2021 https://github.com/RaphaelViniciuss. All rights reserved.
//

import UIKit

public protocol SceneView {
    func setupView()
    func buildSubviews()
    func setupConstraints()
}

extension SceneView {
    func setupView() {
        buildSubviews()
        setupConstraints()
    }
}
