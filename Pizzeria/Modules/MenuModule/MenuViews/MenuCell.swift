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
        let imageStringURL: String
    }

    private enum Constants {
        static let defaultCornerRadiusOfFirstCell: CGFloat = 20
        static let dateAndSourceLabelText = " Source: "
        static let imageRatio: CGFloat = 0.562
    }

    private lazy var dateAndSourceLabel = UILabel(textStyle: .footnote)
    private lazy var titleLabel: UILabel = .init(textStyle: .title2)
    private lazy var descriptionLabel = UILabel(textStyle: .body)

    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()

    private lazy var imageContainer: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()

    private lazy var articleImageView: UIImageView = {
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

    override func prepareForReuse() {
        super.prepareForReuse()
        clearPreviousConfiguration()
    }

    func configure(with displayData: DisplayData) {
        loadingIndicator.startAnimating()
        titleLabel.text = displayData.title
        descriptionLabel.text = displayData.description
    }

    func makeUpperCornersRounded(radius: CGFloat = Constants.defaultCornerRadiusOfFirstCell) {
        layer.cornerRadius = radius
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    func setImage(_ imageData: Data?) {
        loadingIndicator.stopAnimating()
        guard let imageData = imageData, let fetchedImage = UIImage(data: imageData) else {
            articleImageView.image = .noImageIcon
            return
        }
        articleImageView.image = fetchedImage
    }

    func getImageData() -> Data? {
        if let jpegImage = articleImageView.image?.jpegData(compressionQuality: 1) {
            return jpegImage
        }
        return articleImageView.image?.pngData()
    }

    private func clearPreviousConfiguration() {
        // Do preparation if needed
    }

    private func setupSubviews() {
        imageContainer.addSubviews([loadingIndicator, articleImageView])
        contentView.addSubviews([imageContainer, dateAndSourceLabel, titleLabel, descriptionLabel])

        NSLayoutConstraint.activate([
            articleImageView.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
            articleImageView.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor),
            articleImageView.widthAnchor.constraint(lessThanOrEqualTo: imageContainer.widthAnchor, multiplier: 1),
            articleImageView.heightAnchor.constraint(lessThanOrEqualTo: imageContainer.heightAnchor, multiplier: 1),

            loadingIndicator.centerXAnchor.constraint(equalTo: imageContainer.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: imageContainer.centerYAnchor),

            imageContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageContainer.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageContainer.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1),
            imageContainer.heightAnchor.constraint(equalTo: imageContainer.widthAnchor, multiplier: Constants.imageRatio),

            dateAndSourceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            dateAndSourceLabel.topAnchor.constraint(equalTo: imageContainer.bottomAnchor, constant: 8),
            dateAndSourceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: dateAndSourceLabel.bottomAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),

            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24)
        ])

        dateAndSourceLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        titleLabel.setContentHuggingPriority(.defaultHigh - 1, for: .vertical)
    }
}
