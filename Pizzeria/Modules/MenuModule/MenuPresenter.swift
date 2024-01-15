//
//  MenuPresenter.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 14.01.2024.
//

import Foundation
import UIKit

final class MenuPresenter {
    private struct State {
        private var items = [MenuItem]()

        mutating func updateItems(with items: [MenuItem]) {
            self.items = items
        }

        func getItem(at indexPath: IndexPath) -> MenuItem {
            return items[indexPath.row]
        }

        func getItemsCount() -> Int {
            return items.count
        }
    }

    private weak var view: MenuInput?
    private var dataManager: AppDataManager
    private var state: State

    init(view: MenuInput, dataManager: AppDataManager) {
        self.view = view
        self.dataManager = dataManager
        state = State()
        updateMenuState()
    }

    private func updateMenuState() {
        dataManager.getMenu { [weak self] result in
            guard let self else { return }
            sleep(3)
            switch result {
            case let .success(menuItems):
                state.updateItems(with: menuItems)
                view?.reloadMenuTableView()
            case let .failure(error):
                print(error)
            }
        }
    }
}

extension MenuPresenter: MenuOutput {
    typealias MenuDisplayData = MenuCell.DisplayData

    func getNumberOfRowsInSection(_: Int) -> Int {
        state.getItemsCount()
    }

    func getDisplayDataForItem(at indexPath: IndexPath) -> MenuDisplayData {
        let menuItem = state.getItem(at: indexPath)
        return MenuDisplayData(menuItem)
    }

    func getImageData(at indexPath: IndexPath, completion: @escaping (Data?) -> Void) {
        let menuItem = state.getItem(at: indexPath)
        dataManager.getImageData(from: menuItem.imageStringURL) { [weak self] result in
            guard let self, state.getItem(at: indexPath) == menuItem else { return }
            switch result {
            case let .success(imageData):
                completion(imageData)
            case .failure:
                completion(nil)
            }
        }
    }

    func didTapOnCurrentCityButton() {
        print("current city Button tapped")
    }

    func didTapOnCell(at indexPath: IndexPath) {
        let chosenItem = state.getItem(at: indexPath)
        print("\(chosenItem.title) has been chosen (tapped) by the user")
    }
}

private extension MenuCell.DisplayData {
    init(_ item: MenuItem) {
        title = item.title
        description = item.restaurantChain
        price = "от 405 р"
        imageStringURL = item.imageStringURL
    }
}
