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

    private lazy var bannersView: BannersView = {
        let view = BannersView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var categoriesView: CategoriesView = {
        let view = CategoriesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .pizzeriaBackground
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
            bannersView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bannersView.topAnchor.constraint(equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor , multiplier: 1),
            bannersView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            categoriesView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            categoriesView.topAnchor.constraint(equalToSystemSpacingBelow: bannersView.bottomAnchor, multiplier: 1),
            categoriesView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),

            menuTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuTableView.topAnchor.constraint(equalToSystemSpacingBelow: categoriesView.bottomAnchor, multiplier: 1),
            menuTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    @objc private func currentCityButtonTapped() {
        // TODO: Add action on Tap
    }
}

extension MenuViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return stub.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reuse(MenuCell.self, indexPath)
        if indexPath.row == 0 {
            cell.makeUpperCornersRounded()
        }

        cell.configure(with: stub[indexPath.row])
        return cell
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: tell Presenter about tap
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

let stub = [MenuCell.DisplayData(title: "Ветчина и грибы",
                                 description: "Ветчина, шампиньоны, увеличенная порция моцареллы, томатный соус",
                                 price: "от 345 р",
                                 image: UIImage(named: "Buffalo1")!),
            MenuCell.DisplayData(title: "Баварские колбаски",
                                 description: "Баварские колбаски,ветчина, пикантная пепперони, острая чоризо, моцарелла, томатный соус",
                                 price: "от 345 р",
                                 image: UIImage(named: "bavar2")!),
            MenuCell.DisplayData(title: "Нежный лосось",
                                 description: "Лосось, томаты черри, моцарелла, соус песто",
                                 price: "от 345 р",
                                 image: UIImage(named: "losos3")!),
            MenuCell.DisplayData(title: "Пицца четыре сыра",
                                 description: "Соус Карбонара, Сыр Моцарелла, Сыр Пармезан, Сыр Роккфорти, Сыр Чеддер (тёртый)",
                                 price: "от 345 р",
                                 image: UIImage(named: "chees4")!)]
