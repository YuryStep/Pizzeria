//
//  Category.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 14.01.2024.
//

import Foundation

enum Category: String, Codable, CaseIterable {
    case pizza = "Pizza"
    case burger = "Burger"
    case desserts = "Desserts"
    case drinks = "Drinks"
}
