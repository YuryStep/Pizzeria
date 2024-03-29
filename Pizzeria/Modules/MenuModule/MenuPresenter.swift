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

        func getItem(at indexPath: IndexPath) -> MenuDisplayData {
            return items[indexPath.row]
        }
    }

    private weak var view: MenuInput?
    private var dataManager: AppDataManager
    private var state: State

    init(view: MenuInput, dataManager: AppDataManager) {
        self.view = view
        self.dataManager = dataManager
        state = State()
    }
}

extension MenuPresenter: MenuOutput {
    func updateMenuState() {
        dataManager.getMenu { [weak self] result in
            guard let self else { return }
            switch result {
            case let .success(menuItems):
                updateMenuWithoutImages(using: menuItems)
                updateMenuWithImages()
            case let .failure(error):
                print(error)
            }
        }
    }

    func getSnapshotItems() -> [MenuCell.DisplayData] {
        return state.items
    }

    func didTapOnCurrentCityButton() {
        print("current city Button tapped")
    }

    func didTapOnCell(at indexPath: IndexPath) {
        let chosenItem = state.getItem(at: indexPath)
        print("\(chosenItem.title) has been chosen (tapped) by the user")
    }

    func getFirstRowForCell(with category: Category) -> Int? {
        return state.items.firstIndex { $0.category == category.rawValue }
    }

    private func updateMenuWithoutImages(using menuItems: [MenuItem]) {
        var updatedState = [MenuDisplayData]()
        for menuItem in menuItems {
            let displayDataItem = MenuDisplayData(menuItem)
            updatedState.append(displayDataItem)
        }
        state.updateItems(with: updatedState)
        view?.updateSnapshot()
    }

    private func updateMenuWithImages() {
        for menuItem in state.items {
            let itemIndex = state.items.firstIndex { $0.id == menuItem.id }
            dataManager.getImageData(from: menuItem.imageStringURL) { [weak self] result in
                guard let self else { return }
                switch result {
                case let .success(imageData):
                    state.items[itemIndex!].imageData = imageData
                    view?.updateSnapshot()
                case .failure:
                    return
                }
            }
        }
    }
}

private extension MenuCell.DisplayData {
    init(_ item: MenuItem) {
        id = item.id
        category = item.category
        title = item.title
        description = item.restaurantChain
        price = "от 405 р"
        imageStringURL = item.imageStringURL
        imageData = item.imageData
    }
}
