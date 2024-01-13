//
//  MenuViewController.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 13.01.2024.
//

import UIKit

final class MenuViewController: UIViewController {
    private enum Constants {
        static let currentCityTitle = "Москва"
        static let currentCityButtonImage = "chevron.down"
        static let currentCityTitleImagePadding: CGFloat = 4
    }

    private lazy var currentCityButton: UIButton = {
        let currentCityButton = UIButton(type: .system)
        currentCityButton.semanticContentAttribute = .forceRightToLeft
        currentCityButton.addTarget(self, action: #selector(currentCityButtonTapped), for: .touchUpInside)

        var config = UIButton.Configuration.plain()
        config.title = Constants.currentCityTitle
        config.image = UIImage(systemName: Constants.currentCityButtonImage)
        config.baseForegroundColor = .black
        config.imagePadding = Constants.currentCityTitleImagePadding

        currentCityButton.configuration = config
        return currentCityButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
    }

    private func setupNavigationBar() {
        let currentCityBarButton = UIBarButtonItem(customView: currentCityButton)
        navigationItem.leftBarButtonItem = currentCityBarButton
    }

    private func setupView() {
        view.backgroundColor = .pizzeriaBackground
    }

    @objc private func currentCityButtonTapped() {
        // TODO: Add action on Tap
    }
}
