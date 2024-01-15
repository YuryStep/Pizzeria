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
    func scrollTableToCell(at: IndexPath)
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

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return CategoriesView()
    }
}

extension MenuViewController: MenuInput {
    func reloadMenuTableView() {
        menuTableView.reloadData()
    }
    
    func scrollTableToCell(at: IndexPath) {
        // TODO: Add Logic of scrolling to the firstItem of Category
    }
}
