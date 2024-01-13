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

    private lazy var bannersView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var categoriesView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .blue //.pizzeriaBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
    }

    private func setupNavigationBar() {
        let barButton = UIBarButtonItem(customView: currentCityButton)
        navigationItem.leftBarButtonItem = barButton
    }

    private func setupView() {
        view.backgroundColor = .pizzeriaBackground
        view.addSubviews([bannersView, categoriesView, menuTableView])

        NSLayoutConstraint.activate([
            bannersView.leftAnchor.constraint(equalTo: view.leftAnchor),
            bannersView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor , multiplier: 1),
            bannersView.rightAnchor.constraint(equalTo: view.rightAnchor),
            bannersView.heightAnchor.constraint(equalToConstant: 112),

            categoriesView.leftAnchor.constraint(equalTo: view.leftAnchor),
            categoriesView.topAnchor.constraint(equalToSystemSpacingBelow: bannersView.bottomAnchor, multiplier: 1),
            categoriesView.rightAnchor.constraint(equalTo: view.rightAnchor),
            categoriesView.heightAnchor.constraint(equalToConstant: 32),

            menuTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            menuTableView.topAnchor.constraint(equalToSystemSpacingBelow: categoriesView.bottomAnchor, multiplier: 1),
            menuTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            menuTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    @objc private func currentCityButtonTapped() {
        // TODO: Add action on Tap
    }
}

extension MenuViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reuse(MenuCell.self, indexPath)
        if indexPath.row == 0 {
            cell.makeUpperCornersRounded()
        }

        // TODO: Remove HardCode
        let cellDisplayData = MenuCell.DisplayData(title: "Пицца – Пепперони",
                                                   description: "Тесто, пицца соус, моцарелла, шампиньоны, пепперони.",
                                                   price: "419",
                                                   imageStringURL: "https://the-cafe.ru/product/picca-pepperoni/")
        cell.configure(with: cellDisplayData)
        cell.setImage(UIImage(named: "pepperoni")?.pngData())
        return cell
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: tell Presenter about tap
        menuTableView.deselectRow(at: indexPath, animated: true)
    }
}
