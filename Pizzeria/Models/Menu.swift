//
//  Menu.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 14.01.2024.
//

import Foundation

struct Menu: Codable {
    let type: String?
    var menuItems: [MenuItem]?
}

struct MenuItem: Codable, Hashable, Identifiable {
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case imageStringURL = "image"
        case restaurantChain
        case category
        case price
        case imageData
    }

    let id: Int
    let title: String
    let imageStringURL: String
    let restaurantChain: String
    var imageData: Data?
    var price: String?
    var category: String?
}
