//
//  DividerView.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 11/12/21.
//

import UIKit

final class DividerView: UIView, SceneView {

    // MARK: - Metrics
    private struct Metrics {
        static let heightSize = 1
    }

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // MARK: - Scene
    func setupView() {
        backgroundColor = RestaurantUIKit.Color.divider
        setupConstraints()
    }

    func buildSubviews() { }

    func setupConstraints() { }
}
