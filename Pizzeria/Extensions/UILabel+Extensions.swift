//
//  UILabel+Extensions.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 13.01.2024.
//

import UIKit

extension UILabel {
    convenience init(textStyle: UIFont.TextStyle, color: UIColor = .black, numberOfLines: Int = 0) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontForContentSizeCategory = true
        self.numberOfLines = numberOfLines
        font = .preferredFont(forTextStyle: textStyle)
        textColor = color

        switch textStyle {
        case .title2: font = UIFont.boldSystemFont(ofSize: font.pointSize)
        case .body: textColor = .systemGray
        default: return
        }
    }
}
