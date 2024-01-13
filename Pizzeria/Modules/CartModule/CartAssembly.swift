//
//  CartAssembly.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 13.01.2024.
//

import UIKit

enum CartAssembly {
    private enum Constants {
        static let tabIconName = "Корзина"
        static let tabImageName = "basket.fill"
    }

    static func makeModule() -> UIViewController {
        let cartController = CartController()

        let tabImage = UIImage(systemName: Constants.tabImageName)
        cartController.tabBarItem = UITabBarItem(title: Constants.tabIconName, image: tabImage, tag: 1)

        return cartController.wrappedInNavigationController()
    }
}
