//
//  MenuSectionCollectionViewCell.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 08/12/21.
//

import UIKit

class MenuSectionCell: UICollectionViewCell, SceneView {

    // MARK: Public properties
    var sectionTitle: String? {
        didSet {
            titleLabel.text = sectionTitle ?? ""
            titleLabel.sizeToFit()
        }
    }

    // MARK: Overrider properties
    override var isHighlighted: Bool {
        willSet {
            onSelected(newValue)
        }
    }

    override var isSelected: Bool {
        willSet {
            onSelected(newValue)
        }
    }

    // MARK: - Metrics
    private struct Metrics {
        static let titleHorizontalSpacing: CGFloat = 10
        static let indicatorTopSpacing: CGFloat = 4
        static let indicatorHeightSize: CGFloat = 2

    }

    // MARK: Views
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = RestaurantUIKit.font(family: .montserrat, weight: .regular, typography: .body)
        label.textColor = .lightGray
        label.textAlignment = .center
        label.text = ""
        return label
    }()

    private var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = RestaurantUIKit.Color.lineIndicatorColor
        view.isHidden = true
        return view
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
        contentView.addSubview(indicatorView)
    }

    func setupConstraints() {
        titleLabel.layout(using: [
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.titleHorizontalSpacing),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.titleHorizontalSpacing),
        ])

        indicatorView.layout(using: [
            indicatorView.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: Metrics.indicatorTopSpacing),
            indicatorView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            indicatorView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            indicatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            indicatorView.heightAnchor.constraint(equalToConstant: Metrics.indicatorHeightSize)
        ])
    }

    // MARK: Private methods
    private func onSelected(_ newValue: Bool) {
        titleLabel.textColor = newValue ? RestaurantUIKit.Color.menuTitleEnabled : RestaurantUIKit.Color.menuTitleDisabled
        indicatorView.isHidden = !newValue
    }
}


