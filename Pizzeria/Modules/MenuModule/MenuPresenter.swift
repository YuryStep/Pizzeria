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
        private var items = [ProductItem]()

        mutating func updateItems(with items: [ProductItem]) {
            self.items = items
        }

        func getItem(at indexPath: IndexPath) -> ProductItem {
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
        getLatestProductList()
    }
    
    private func getLatestProductList() {
        let productList = dataManager.getLatestProductList()
        state.updateItems(with: productList)
    }
}

extension MenuPresenter: MenuOutput {
    typealias MenuDisplayData = MenuCell.DisplayData

    func getNumberOfRowsInSection(_: Int) -> Int {
        state.getItemsCount()
    }

    func getDisplayDataForItem(at indexPath: IndexPath) -> MenuDisplayData {
        let productItem = state.getItem(at: indexPath)
        return MenuDisplayData(title: productItem.title,
                               description: productItem.description,
                               price: String(productItem.price),
                               image: UIImage(data: productItem.imageData)!)
    }

    func didTapOnCurrentCityButton() {
        print("current city Button tapped")
    }
    
    func didTapOnCell(at indexPath: IndexPath) {
        let chosenItem = state.getItem(at: indexPath)
        print("\(chosenItem.title) has been chosen (tapped) by the user")
    }
}
