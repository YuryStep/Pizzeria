//
//  ProfileAssembly.swift
//  Pizzeria
//
//  Created by Юрий Степанчук on 13.01.2024.
//

import UIKit

enum ProfileAssembly {
    private enum Constants {
        static let tabIconName = "Профиль"
        static let tabImageName = "person.fill"
    }

    static func makeModule() -> UIViewController {
        let profileController = ProfileController()

        let tabImage = UIImage(systemName: Constants.tabImageName)
        profileController.tabBarItem = UITabBarItem(title: Constants.tabIconName, image: tabImage, tag: 2)

        return profileController.wrappedInNavigationController()
    }
}
