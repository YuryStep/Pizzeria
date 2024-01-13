//
//  ProfileController.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 13.01.2024.
//

import UIKit

final class ProfileController: UIViewController {
    private enum Constants {
        static let stabText = "Раздел в разработке"
    }

    private lazy var label: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Constants.stabText
        label.textColor = .darkGray
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    private func setupView() {
        view.backgroundColor = .pizzeriaBackground
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
