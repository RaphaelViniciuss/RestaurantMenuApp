//
//  MenuSectionHeaderCollectionViewCell.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 08/12/21.
//

import UIKit

class MenuItemHeaderCell: UICollectionViewCell, SceneView {

    // MARK: Metrics
    private struct Metrics {
        static let horizontalSpacing: CGFloat = 20
    }

    // MARK: Views
    var titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.font = UIFont(name: "Montserrat-Regular", size: 20.0)
        label.textColor = UIColor(red: 0.09, green: 0.09, blue: 0.09, alpha: 1.00)
        label.numberOfLines = .zero
        label.text = ""
        return label
    }()

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: SceneView
    func buildSubviews() {
        contentView.addSubview(titleLabel)
    }

    func setupConstraints() {
        titleLabel.layout(using: [
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.horizontalSpacing),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.horizontalSpacing),
        ])
    }

    // MARK: Public Methods
    func configure(with title: String) {
        titleLabel.text = title
        titleLabel.sizeToFit()
    }
}
