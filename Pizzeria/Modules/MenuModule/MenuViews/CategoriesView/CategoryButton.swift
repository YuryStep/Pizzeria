//
//  CategoryButton.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 14.01.2024.
//

import UIKit

protocol CategoryButtonDelegate: AnyObject {
    func categoryButtonTapped(_: UIButton, category: Category)
}

class CategoryButton: UIButton {
    weak var delegate: CategoryButtonDelegate?
    var category: Category?

    init(category: Category) {
        super.init(frame: .zero)
        self.category = category
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        setup()
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.15, delay: 0, options: [.allowUserInteraction, .beginFromCurrentState]) {
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.94, y: 0.94) : .identity
            }
        }
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
        layer.borderWidth = 1
        layer.borderColor = UIColor.pizzeriaAccent.cgColor

        setTitleColor(.pizzeriaAccent, for: .normal)
        setTitleColor(.pizzeriaAccent, for: .selected)
        setTitleColor(.pizzeriaAccent, for: .highlighted)

        backgroundColor = .clear

        setTitle(category?.rawValue, for: .normal)

        var config = UIButton.Configuration.plain()
        config.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10)
        configuration = config
    }

    @objc private func buttonTapped() {
        if let category = category {
            delegate?.categoryButtonTapped(self, category: category)
        }
    }
}
