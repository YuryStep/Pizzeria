//
//  BannersView.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 14.01.2024.
//

import UIKit

protocol BannersViewDelegate: AnyObject {
    func bannerTapped(_ banner: Int)
}

final class BannersView: UIView {
    weak var delegate: BannersViewDelegate?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private lazy var bannersStackView: UIStackView = {
        let banner1 = UIImageView(image: UIImage(named: "banner0"))
        let banner2 = UIImageView(image: UIImage(named: "banner0"))

        let stackView = UIStackView(arrangedSubviews: [banner1, banner2])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupSubviews()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("This class does not support NSCoder")
    }

    private func setupSubviews() {
        scrollView.addSubview(bannersStackView)
        addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),

            scrollView.leadingAnchor.constraint(equalTo: bannersStackView.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: bannersStackView.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: bannersStackView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bannersStackView.bottomAnchor),

            scrollView.heightAnchor.constraint(equalTo: bannersStackView.heightAnchor)
        ])
    }
}
