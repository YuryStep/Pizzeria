//
//  CategoryButton.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 14.01.2024.
//

import UIKit

class CategoryButton: UIButton {
    private var cornerRadius: CGFloat = 15

    init(cornerRadius: CGFloat = 15,
         title: String? = nil,
         textColor: UIColor? = nil,
         backgroundColor: UIColor? = nil) {
        super.init(frame: .zero)
        self.cornerRadius = cornerRadius
        setup()

        if let title = title {
            setTitle(title, for: .normal)
        }

        if let textColor = textColor {
            setTitleColor(textColor, for: .normal)
        }

        if let backgroundColor = backgroundColor {
            self.backgroundColor = backgroundColor
        }
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = cornerRadius
        layer.borderWidth = 1
        layer.borderColor = UIColor.pizzeriaAccent.cgColor

        setTitleColor(.pizzeriaAccent, for: .normal)
        setTitleColor(.pizzeriaAccentColorTransparent, for: .highlighted)
        backgroundColor = .clear

        var config = UIButton.Configuration.plain()
        config.contentInsets = NSDirectionalEdgeInsets(top: 5,
                                                       leading: 10,
                                                       bottom: 5,
                                                       trailing: 10)
        configuration = config
    }
}

