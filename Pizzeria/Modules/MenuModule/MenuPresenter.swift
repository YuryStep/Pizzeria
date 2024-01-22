//
//  MenuPresenter.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 14.01.2024.
//

import Foundation

final class MenuPresenter {
    typealias MenuDisplayData = MenuCell.DisplayData

    private struct State {
        var items = [MenuDisplayData]()

        mutating func updateItems(with items: [MenuDisplayData]) {
            self.items = items
        }

        mutating func setImageDataForItem(at indexPath: IndexPath, data: Data) {
            items[indexPath.row].imageData = data
        }

        func getItem(at indexPath: IndexPath) -> MenuDisplayData {
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
            switch result {
            case let .success(menuItems):
                updateMenuItemsWithoutImages(using: menuItems)
            case let .failure(error):
                print(error)
            }
        }
    }

    private func updateMenuItemsWithoutImages(using menuItems: [MenuItem]) {
        var updatedState = [MenuDisplayData]()
        menuItems.forEach { menuItem in
            let displayDataItem = MenuDisplayData(menuItem)
            updatedState.append(displayDataItem)
        }
        state.updateItems(with: updatedState)
        view?.reloadMenuItems()
    }

}

extension MenuPresenter: MenuOutput {
    func getNumberOfRowsInSection(_: Int) -> Int {
        state.getItemsCount()
    }

    func getDisplayDataForItem(at indexPath: IndexPath) -> MenuDisplayData {
        return state.getItem(at: indexPath)
    }

    func getDisplayDataWithImage(at indexPath: IndexPath, completion: @escaping (MenuDisplayData?) -> Void) {
        let menuItem = state.getItem(at: indexPath)
        dataManager.getImageData(from: menuItem.imageStringURL) { [weak self] result in
            guard let self, state.getItem(at: indexPath) == menuItem else { return }
            switch result {
            case let .success(imageData):
                state.setImageDataForItem(at: indexPath, data: imageData)
                let displayDataWithImage = state.getItem(at: indexPath)
                completion(displayDataWithImage)
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
        id = item.id
        title = item.title
        description = item.restaurantChain
        price = "от 405 р"
        imageStringURL = item.imageStringURL
        imageData = item.imageData
    }
}
