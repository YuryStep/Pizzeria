//
//  DataManager.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 14.01.2024.
//

import Foundation

protocol AppDataManager {
    func getMenu(completion: @escaping ((Result<[MenuItem], NetworkError>) -> Void))
    func getImageData(from urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void)
}

final class DataManager: AppDataManager {
    private enum Constants {
        static let cachedMenuItemsKey = "cachedMenuItemsKey"
    }

    static let shared = DataManager(
        networkService: NetworkService(),
        persistenceService: PersistenceService()
    )

    private let networkService: AppNetworkService
    private let persistenceService: AppPersistenceService

    private init(networkService: AppNetworkService, persistenceService: AppPersistenceService) {
        self.networkService = networkService
        self.persistenceService = persistenceService
    }

    func getMenu(completion: @escaping (Result<[MenuItem], NetworkError>) -> Void) {
        if let cachedItems: [MenuItem] = persistenceService.readValue(forKey: Constants.cachedMenuItemsKey) {
            completion(.success(cachedItems))
        } else {
            var allCategoriesItems: [MenuItem] = []
            let dispatchGroup = DispatchGroup()
            for category in Category.allCases {
                dispatchGroup.enter()
                networkService.downloadMenu(category: category.rawValue) { [weak self] result in
                    guard let self else { return }
                    defer { dispatchGroup.leave() }
                    switch result {
                    case let .success(menuItems):
                        let itemsWithCategories = addCategoryTo(menuItems, category: category)
                        allCategoriesItems.append(contentsOf: itemsWithCategories)
                    case let .failure(error):
                        completion(.failure(error))
                        return
                    }
                }
            }
            dispatchGroup.notify(queue: .main) {
                self.saveInStorageIfNotEmpty(allCategoriesItems)
                completion(.success(allCategoriesItems))
            }
        }
    }

    func getImageData(from urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        downloadImageData(from: urlString) { result in
            completion(result)
        }
    }

    private func addCategoryTo(_ items: [MenuItem], category: Category) -> [MenuItem] {
        return items.map { item in
            var newItem = item
            newItem.category = category.rawValue
            return newItem
        }
    }

    private func saveInStorageIfNotEmpty(_ items: [MenuItem]) {
        guard !items.isEmpty else { return }
        persistenceService.save(items, forKey: Constants.cachedMenuItemsKey)
    }

    private func downloadImageData(from urlString: String, completion: @escaping (Result<Data, NetworkError>) -> Void) {
        if let imageData = persistenceService.getData(forKey: urlString) {
            completion(.success(imageData))
        } else {
            networkService.downloadImageData(from: urlString) { [weak self] response in
                guard let self else { return }
                switch response {
                case let .success(imageData):
                    self.persistenceService.saveData(imageData, forKey: urlString)
                    completion(.success(imageData))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }
}
