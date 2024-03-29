//
//  CategoriesView.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 14.01.2024.
//

import UIKit

protocol CategoriesViewDelegate: AnyObject {
    func categoryTapped(_ category: Category)
}

final class CategoriesView: UIView {
    weak var delegate: CategoriesViewDelegate?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()

    private lazy var categoryButtons: [CategoryButton] = {
        var buttons = [CategoryButton]()
        for category in Category.allCases {
            let categoryButton = CategoryButton(category: category)
            categoryButton.delegate = self
            buttons.append(categoryButton)
        }
        return buttons
    }()

    private lazy var categoriesStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: categoryButtons)
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
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),

            scrollView.leadingAnchor.constraint(equalTo: categoriesStackView.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: categoriesStackView.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: categoriesStackView.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: categoriesStackView.bottomAnchor),

            scrollView.heightAnchor.constraint(equalTo: categoriesStackView.heightAnchor)
        ])
    }
}

extension CategoriesView: CategoryButtonDelegate {
    func categoryButtonTapped(_ button: CategoryButton, category: Category) {
        selectButton(button: button)
        delegate?.categoryTapped(category)
    }

    private func selectButton(button: CategoryButton) {
        guard let buttons = categoriesStackView.arrangedSubviews as? [CategoryButton] else { return }
        for button in buttons {
            setNormal(button: button)
        }
        setLastTapped(button: button)
    }

    private func setLastTapped(button: CategoryButton) {
        button.isLastTapped = true
    }

    private func setNormal(button: CategoryButton) {
        button.isLastTapped = false
    }
}
