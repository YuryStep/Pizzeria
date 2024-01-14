//
//  UICollectionView+Extensions.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 14.01.2024.
//

import UIKit

extension UICollectionView {

    func register<Cell: UICollectionViewCell>(_ cellType: Cell.Type) {
        register(cellType, forCellWithReuseIdentifier: cellType.identifier)
    }

    func getReuseCell<Cell: UICollectionViewCell>(_ cellType: Cell.Type, indexPath: IndexPath) -> Cell {
        dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as! Cell
    }
}

extension UICollectionReusableView {
    var identifier: String {
        .init(describing: self)
    }

    static var identifier: String {
        .init(describing: self)
    }
}
