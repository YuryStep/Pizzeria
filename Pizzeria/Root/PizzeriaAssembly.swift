//
//  PizzeriaAssembly.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 13.01.2024.
//

import UIKit

enum PizzeriaAssembly {
    static func makeModule() -> UIViewController {
        let menu = MenuAssembly.makeModule()
        let contacts = ContactsAssembly.makeModule()
        let profile = ProfileAssembly.makeModule()
        let cart = CartAssembly.makeModule()

        let tabBarController = makeTabBarController(with: [menu, contacts, profile, cart])
        tabBarController.tabBar.tintColor = .pizzeriaAccent
        return tabBarController
    }

    private static func makeTabBarController(with viewControllers: [UIViewController]) -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = viewControllers
        turnOffTabBarTransparency()
        return tabBarController
    }

    private static func turnOffTabBarTransparency() {
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
    }
}
