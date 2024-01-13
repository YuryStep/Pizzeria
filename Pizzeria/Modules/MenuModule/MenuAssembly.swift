//
//  MenuAssembly.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 13.01.2024.
//

import UIKit

enum MenuAssembly {
    private enum Constants {
        static let tabIconName = "Меню"
        static let tabImageName = "fork.knife"
    }

    static func makeModule() -> UIViewController {
//        let menuView = FeedView()
        let menuViewController = MenuViewController()   // MenuViewController(view: menuView)
//        let menuPresenter = MenuPresenter(view: menuViewController, dataManager: DataManager.shared)
//        menuView.delegate = menuViewController
//        menuViewController.presenter = menuPresenter

        let tabImage = UIImage(systemName: Constants.tabImageName)
        menuViewController.tabBarItem = UITabBarItem(title: Constants.tabIconName, image: tabImage, tag: 0)
        return menuViewController.wrappedInNavigationController()
    }
}
