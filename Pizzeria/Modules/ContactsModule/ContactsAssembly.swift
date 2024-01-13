//
//  ContactsAssembly.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 13.01.2024.
//

import UIKit

enum ContactsAssembly {
    private enum Constants {
        static let tabIconName = "Контакты"
        static let tabImageName = "pin.fill"
    }

    static func makeModule() -> UIViewController {
        let contactsController = ContactsController()

        let tabImage = UIImage(systemName: Constants.tabImageName)
        contactsController.tabBarItem = UITabBarItem(title: Constants.tabIconName, image: tabImage, tag: 1)

        return contactsController.wrappedInNavigationController()
    }
}
