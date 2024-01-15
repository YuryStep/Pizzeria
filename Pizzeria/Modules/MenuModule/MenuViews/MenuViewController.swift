//
//  MenuViewController.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 13.01.2024.
//

import UIKit

protocol MenuOutput: AnyObject {
    func getNumberOfRowsInSection(_: Int) -> Int
    func getDisplayDataForItem(at indexPath: IndexPath) -> MenuCell.DisplayData
    func getImageData(at indexPath: IndexPath, completion: @escaping (Data?) -> Void)
    func didTapOnCurrentCityButton()
    func didTapOnCell(at indexPath: IndexPath)
}

protocol MenuInput: AnyObject {
    func reloadMenuTableView()
}

final class MenuViewController: UIViewController {
    private enum Constants {
        static let currentCityTitle = "Москва"
        static let currentCityButtonImage = "chevron.down"
        static let currentCityTitleImagePadding: CGFloat = 4
    }

    var presenter: MenuOutput!

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

    private lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MenuCell.self)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .pizzeriaBackground
        tableView.separatorInset = .zero
        let headerRect = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 132)
        tableView.tableHeaderView = BannersView(frame: headerRect)
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
            menuTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }

    @objc private func currentCityButtonTapped() {
        presenter.didTapOnCurrentCityButton()
    }
}

extension MenuViewController: UITableViewDataSource {
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getNumberOfRowsInSection(_: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reuse(MenuCell.self, indexPath)
        if indexPath.row == 0 {
            cell.makeUpperCornersRounded()
        }

        let displayData = presenter.getDisplayDataForItem(at: indexPath)
        cell.configure(with: displayData)
        presenter.getImageData(at: indexPath) { imageData in
            cell.setImage(imageData)
        }
        return cell
    }
}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didTapOnCell(at: indexPath)
    }

    func tableView(_: UITableView, viewForHeaderInSection _: Int) -> UIView? {
        let headerView = CategoriesView()
        headerView.delegate = self
        return headerView
    }
}

extension MenuViewController: MenuInput {
    func reloadMenuTableView() {
        menuTableView.reloadData()
    }
}

extension MenuViewController: CategoriesViewDelegate {
    func categoryTapped(_ category: Category) {
        switch category {
        case .burger: scrollTableViewToCell(at: IndexPath(row: 0, section: 0))
        case .desserts: scrollTableViewToCell(at: IndexPath(row: 10, section: 0))
        case .drinks: scrollTableViewToCell(at: IndexPath(row: 30, section: 0))
        case .pizza: scrollTableViewToCell(at: IndexPath(row: 20, section: 0))
        }
    }

    // TODO: Move scrolling actions call to presenter
    private func scrollTableViewToCell(at indexPath: IndexPath) {
        guard menuTableView.numberOfSections > 0,
              menuTableView.numberOfRows(inSection: 0) > 0 else { return }

        menuTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
