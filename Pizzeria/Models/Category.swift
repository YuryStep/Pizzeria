//
//  Category.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 14.01.2024.
//

import Foundation

enum Category: String, Codable, CaseIterable {
    case pizza = "Пицца"
    case combo = "Комбо"
    case desserts = "Десерты"
    case drinks = "Напитки"
}
