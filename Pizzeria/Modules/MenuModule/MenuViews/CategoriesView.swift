//
//  CategoriesView.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 14.01.2024.
//

import UIKit

protocol CategoriesViewDelegate: AnyObject {
    func CategoryTapped(_ Category: Int)
}

final class CategoriesView: UIView {
    weak var delegate: CategoriesViewDelegate?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private lazy var categoriesStackView: UIStackView = {
        let button1 = CategoryButton(title: "Пицца",
                                     textColor: .pizzeriaAccent,
                                     backgroundColor: .pizzeriaAccentColorTransparent)
        let button2 = CategoryButton(title: "Комбо",
                                     textColor: .pizzeriaAccent,
                                     backgroundColor: .pizzeriaBackground)
        let button3 = CategoryButton(title: "Десерты",
                                     textColor: .pizzeriaAccent,
                                     backgroundColor: .pizzeriaBackground)
        let button4 = CategoryButton(title: "Напитки",
                                     textColor: .pizzeriaAccent,
                                     backgroundColor: .pizzeriaBackground)

        let stackView = UIStackView(arrangedSubviews: [button1, button2, button3, button4])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .pizzeriaBackground
        setupSubviews()
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("This class does not support NSCoder")
    }

    private func setupSubviews() {
        scrollView.addSubview(categoriesStackView)
        addSubview(scrollView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),

            scrollView.leadingAnchor.constraint(equalTo: categoriesStackView.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: categoriesStackView.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: categoriesStackView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: categoriesStackView.bottomAnchor),

            scrollView.heightAnchor.constraint(equalTo: categoriesStackView.heightAnchor)
        ])
    }

//    @objc private func settingsButtonTapped() {
//        delegate?.settingsButtonTapped()
//    }

}
