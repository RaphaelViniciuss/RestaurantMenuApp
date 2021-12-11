//
//  MenuItemCell.swift
//  RestaurantMenuApp
//
//  Created by Raphael Vinicius on 08/12/21.
//

import UIKit

class MenuItemCell: UICollectionViewCell, SceneView {

    // MARK: Public properties
    var isLastItem: Bool? {
        didSet {
            divider.isHidden = isLastItem ?? false
        }
    }

    // MARK: Metrics
    private struct Metrics {
        struct Label {
            static let nameLabelTopSpacing: CGFloat = 10
            static let infoLabelTopSpacing: CGFloat = 10
            static let priceLabelTopSpacing: CGFloat = 30
        }

        struct Divider {
            static let dividerTopSpacing: CGFloat = 25
            static let dividerHorizontalSpacing: CGFloat = 30
            static let dividerHeightSpacing: CGFloat = 1
            static let dividerBottomspacing: CGFloat = 10
        }
    }

    // MARK: Views
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = RestaurantUIKit.Color.textContent
        label.font = RestaurantUIKit.font(family: .playfairDisplay, weight: .regular, typography: .headline)
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.text = ""
        return label
    }()

    private lazy var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = RestaurantUIKit.Color.textDescription
        label.font = RestaurantUIKit.font(family: .playfairDisplay, weight: .regular, typography: .body)
        label.numberOfLines = .zero
        label.textAlignment = .center
        label.text = ""
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = RestaurantUIKit.Color.textDescription
        label.font = RestaurantUIKit.font(family: .montserrat, weight: .regular, typography: .subheadline)
        label.textAlignment = .center
        label.text = ""
        return label
    }()

    private lazy var divider: DividerView = {
        return DividerView()
    }()

    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Scene view
    func buildSubviews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(infoLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(divider)
    }

    func setupConstraints() {

        nameLabel.layout(using: [
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Metrics.Label.nameLabelTopSpacing),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        infoLabel.layout(using: [
            infoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Metrics.Label.infoLabelTopSpacing),
            infoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])

        priceLabel.layout(using: [
            priceLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: Metrics.Label.priceLabelTopSpacing),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])

        let bottomDivider = divider.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Metrics.Divider.dividerBottomspacing)
        bottomDivider.priority = .defaultLow

        divider.layout(using: [
            divider.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: Metrics.Divider.dividerTopSpacing),
            divider.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Metrics.Divider.dividerHorizontalSpacing),
            divider.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Metrics.Divider.dividerHorizontalSpacing),
            bottomDivider,
            divider.heightAnchor.constraint(equalToConstant: 1)
        ])
    }

    // MARK: Override methods
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        let targetSize = CGSize(width: layoutAttributes.frame.width, height: .zero)
        layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize,
                                                                          withHorizontalFittingPriority: .required,
                                                                          verticalFittingPriority: .fittingSizeLevel)
        return layoutAttributes
    }

    // MARK: Public Methods
    func configure(with item: Restaurant.MenuItem) {
        nameLabel.text = item.name
        nameLabel.sizeToFit()
        infoLabel.text = item.description
        infoLabel.sizeToFit()
        priceLabel.text = item.pricing.first?.priceString
        priceLabel.sizeToFit()
    }
}
