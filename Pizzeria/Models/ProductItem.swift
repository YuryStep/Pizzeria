//
//  ProductItem.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 14.01.2024.
//

import Foundation

struct ProductItem: Decodable {
    let id: Int
    let category: Category
    let title: String
    let description: String
    let price: String
//    let price: Double
//    let imageURL: URL
    let imageData: Data
}
