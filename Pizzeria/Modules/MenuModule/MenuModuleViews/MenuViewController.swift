//
//  MenuViewController.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 13.01.2024.
//

import UIKit

protocol MenuOutput: AnyObject {
    func didTapOnCurrentCityButton()
    func didTapOnCell(at indexPath: IndexPath)
    func getSnapshotItems() -> [MenuCell.DisplayData]
    func updateMenuState()
    func getFirstRowForCell(with category: Category) -> Int?
}

protocol MenuInput: AnyObject {
    func updateSnapshot()
}

final class MenuViewController: UIViewController {
    private typealias DataSource = UITableViewDiffableDataSource<Section, MenuCell.DisplayData>
    private typealias Snapshot = NSDiffableDataSourceSnapshot<Section, MenuCell.DisplayData>

    private enum Constants {
        static let currentCityTitle = "Москва"
        static let currentCityButtonImage = "chevron.down"
        static let currentCityTitleImagePadding: CGFloat = 4
    }

    private enum Section: Int {
        case main
    }

    var presenter: MenuOutput!

    private var menuView: MenuView!

    private lazy var tableViewDataSource: DataSource = {
        let dataSource = DataSource(tableView: menuView.tableView) { tableView, indexPath, cellDisplayData in
            let cell = tableView.reuse(MenuCell.self, indexPath)
            if indexPath.row == 0 { cell.makeUpperCornersRounded() }
            cell.configure(with: cellDisplayData)
            return cell
        }
        return dataSource
    }()

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
        assignDelegationAndCellRegistering()
        presenter.updateMenuState()
        updateSnapshot()
    }

    func updateSnapshot() {
        let snapshotItems = presenter.getSnapshotItems()
        var snapshot = Snapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(snapshotItems, toSection: .main)
        tableViewDataSource.apply(snapshot, animatingDifferences: false)
    }

    private func setupNavigationBar() {
        let barButton = UIBarButtonItem(customView: currentCityButton)
        navigationItem.leftBarButtonItem = barButton
    }

    private func assignDelegationAndCellRegistering() {
        menuView.tableView.register(MenuCell.self)
        menuView.tableView.delegate = self
    }

    @objc private func currentCityButtonTapped() {
        presenter.didTapOnCurrentCityButton()
    }
}

extension MenuViewController: MenuInput {}

extension MenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        presenter.didTapOnCell(at: indexPath)
    }

    func tableView(_: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == Section.main.rawValue else { return nil }
        let headerView = CategoriesView()
        headerView.delegate = self
        return headerView
    }
}

extension MenuViewController: CategoriesViewDelegate {
    func categoryTapped(_ category: Category) {
        guard let row = presenter.getFirstRowForCell(with: category) else { return }
        let section = Section.main.rawValue
        scrollTableViewToCell(at: IndexPath(row: row, section: section))
    }

    private func scrollTableViewToCell(at indexPath: IndexPath) {
        guard menuView.tableView.numberOfSections > 0,
              menuView.tableView.numberOfRows(inSection: 0) > 0 else { return }

        menuView.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}
