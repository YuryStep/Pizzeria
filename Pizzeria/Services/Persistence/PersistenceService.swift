//
//  PersistenceService.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 14.01.2024.
//

import Foundation

protocol AppPersistenceService {
    func saveData(_: Data, forKey key: String)
    func getData(forKey key: String) -> Data?
    func save<T: Encodable>(_: T, forKey key: String)
    func readValue<T: Decodable>(forKey key: String) -> T?
    func clearCache()
}

final class PersistenceService: AppPersistenceService {
    private let cache = NSCache<NSString, NSData>()

    func getData(forKey key: String) -> Data? {
        let key = key as NSString
        if let cachedData = cache.object(forKey: key) {
            return cachedData as Data
        }
        return nil
    }

    func saveData(_ data: Data, forKey key: String) {
        let data = data as NSData
        let key = key as NSString
        cache.setObject(data, forKey: key)
    }

    func save<T: Encodable>(_ object: T, forKey key: String) {
        if let encodedObject = try? JSONEncoder().encode(object) {
            UserDefaults.standard.set(encodedObject, forKey: key)
        }
    }

    func readValue<T: Decodable>(forKey key: String) -> T? {
        guard let encodedObject = UserDefaults.standard.data(forKey: key),
              let decodedObject = try? JSONDecoder().decode(T.self, from: encodedObject)
        else { return nil }
        return decodedObject
    }

    func clearCache() {
        cache.removeAllObjects()
    }
}
