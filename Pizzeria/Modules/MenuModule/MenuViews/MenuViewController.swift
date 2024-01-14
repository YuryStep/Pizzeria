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
        tableView.tableHeaderView = BannersView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 132))
        tableView.separatorInset = .zero
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
        view.addSubview(menuTableView)
        let guide = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([
            menuTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            menuTableView.topAnchor.constraint(equalTo: guide.topAnchor),
            menuTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            menuTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
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

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return CategoriesView()
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
