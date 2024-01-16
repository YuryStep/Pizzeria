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
    func reloadMenuItems()
}

final class MenuViewController: UIViewController {
    private enum Constants {
        static let currentCityTitle = "Москва"
        static let currentCityButtonImage = "chevron.down"
        static let currentCityTitleImagePadding: CGFloat = 4
    }

    var presenter: MenuOutput!
    private var menuView: MenuView!

    private lazy var currentCityButton: UIButton = {
        let cityButton = UIButton(type: .system)
        cityButton.semanticContentAttribute = .forceRightToLeft
        cityButton.addTarget(self, action: #selector(currentCityButtonTapped), for: .touchUpInside)

        var config = UIButton.Configuration.plain()
        config.title = Constants.currentCityTitle
        config.image = UIImage(systemName: Constants.currentCityButtonImage)
        config.baseForegroundColor = .black
        config.imagePadding = Constants.currentCityTitleImagePadding
        cityButton.configuration = config

        return cityButton
    }()

    init(menuView: MenuView) {
        super.init(nibName: nil, bundle: nil)
        self.menuView = menuView
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("This class does not support NSCoder")
    }

    override func loadView() {
        view = menuView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        assignDelegationAndDataSource()
    }

    private func setupNavigationBar() {
        let barButton = UIBarButtonItem(customView: currentCityButton)
        navigationItem.leftBarButtonItem = barButton
    }

    private func assignDelegationAndDataSource() {
        menuView.tableView.register(MenuCell.self)
        menuView.tableView.delegate = self
        menuView.tableView.dataSource = self
    }

    @objc private func currentCityButtonTapped() {
        presenter.didTapOnCurrentCityButton()
    }
}

extension MenuViewController: MenuInput {
    func reloadMenuItems() {
        menuView.reloadTableView()
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

extension MenuViewController: CategoriesViewDelegate {
    func categoryTapped(_ category: Category) {
        switch category {
        case .burger: scrollTableViewToCell(at: IndexPath(row: 0, section: 0))
        case .desserts: scrollTableViewToCell(at: IndexPath(row: 10, section: 0))
        case .pizza: scrollTableViewToCell(at: IndexPath(row: 20, section: 0))
        case .drinks: scrollTableViewToCell(at: IndexPath(row: 30, section: 0))
        }
    }

    private func scrollTableViewToCell(at indexPath: IndexPath) {
        guard menuView.tableView.numberOfSections > 0,
              menuView.tableView.numberOfRows(inSection: 0) > 0 else { return }

        menuView.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
