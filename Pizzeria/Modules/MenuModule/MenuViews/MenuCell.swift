//
//  MenuCell.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 13.01.2024.
//

import UIKit

final class MenuCell: UITableViewCell {
    struct DisplayData {
        let title: String
        let description: String
        let price: String
        let image: UIImage
    }

    private enum Constants {
        static let internalPadding: CGFloat = 8
        static let externalPadding: CGFloat = 16
        static let defaultCornerRadiusOfFirstCell: CGFloat = 20
    }

    private lazy var titleLabel: UILabel = .init(textStyle: .title3)
    private lazy var descriptionLabel = UILabel(textStyle: .subheadline)

    // TODO: Need Refactoring:
    private lazy var priceButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let accentColor: UIColor = .pizzeriaAccent
        button.setTitleColor(accentColor, for: .normal)
        button.setTitleColor(.pizzeriaAccentColorTransparent, for: .highlighted)
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        button.layer.borderColor = accentColor.cgColor

        var config = UIButton.Configuration.plain()
        config.contentInsets = NSDirectionalEdgeInsets(top: 5,
                                                       leading: 10,
                                                       bottom: 5,
                                                       trailing: 10)
        button.configuration = config
        return button
    }()

    private lazy var foodImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("This class does not support NSCoder")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier _: String?) {
        super.init(style: style, reuseIdentifier: MenuCell.reuseIdentifier)
        setupSubviews()
        backgroundColor = .white
    }

    func configure(with displayData: DisplayData) {
        titleLabel.text = displayData.title
        descriptionLabel.text = displayData.description
        priceButton.setTitle(displayData.price, for: .normal)
        foodImageView.image = displayData.image
    }

    func makeUpperCornersRounded(radius: CGFloat = Constants.defaultCornerRadiusOfFirstCell) {
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        clipsToBounds = true
    }

    private func setupSubviews() {
        contentView.addSubviews([foodImageView, titleLabel, descriptionLabel, priceButton])

        NSLayoutConstraint.activate([
            foodImageView.widthAnchor.constraint(equalTo: titleLabel.widthAnchor, multiplier: 1),
            foodImageView.heightAnchor.constraint(equalToConstant: 132),
            foodImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            foodImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.externalPadding),

            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: foodImageView.trailingAnchor, multiplier: 1),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.externalPadding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.internalPadding * -1),

            descriptionLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: foodImageView.trailingAnchor, multiplier: 1),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.internalPadding),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.internalPadding * -1),

            priceButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: Constants.internalPadding),
            priceButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: Constants.internalPadding * -1),

            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: foodImageView.bottomAnchor, constant: Constants.externalPadding),
            contentView.bottomAnchor.constraint(greaterThanOrEqualTo: priceButton.bottomAnchor, constant: Constants.externalPadding)
        ])
    }
}
