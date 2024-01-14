//
//  DataManager.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 14.01.2024.
//
import UIKit
import Foundation

protocol AppDataManager {
    func getLatestProductList() -> [ProductItem]
    func clearCache()
}

final class DataManager: AppDataManager {
    func clearCache() {
        // clearCache
    }

    static let shared = DataManager()

    private init() {
    }

    func getLatestProductList() -> [ProductItem] {
        let stub = [ProductItem(id: 1,
                                category: .pizza,
                                title: "Ветчина и грибы",
                                description: "Ветчина, шампиньоны, увеличенная порция моцареллы, томатный соус",
                                price: "от 345 р",
                                imageData: UIImage(named: "Buffalo1")!.pngData()!),
                    ProductItem(id: 2,
                                category: .pizza,
                                title: "Баварские колбаски",
                                description: "Баварские колбаски,ветчина, пикантная пепперони, острая чоризо, моцарелла, томатный соус",
                                price: "от 345 р",
                                imageData: UIImage(named: "bavar2")!.pngData()!),
                    ProductItem(id: 3,
                                category: .pizza,
                                title: "Нежный лосось",
                                description: "Лосось, томаты черри, моцарелла, соус песто",
                                price: "от 345 р",
                                imageData: UIImage(named: "losos3")!.pngData()!),
                    ProductItem(id: 4,
                                category: .pizza,
                                title: "Пицца четыре сыра",
                                description: "Соус Карбонара, Сыр Моцарелла, Сыр Пармезан, Сыр Роккфорти, Сыр Чеддер (тёртый)",
                                price: "от 345 р",
                                imageData: UIImage(named: "chees4")!.pngData()!)]
        return stub
    }
}
