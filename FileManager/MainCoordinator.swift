//
//  MainCoordinator.swift
//  Fileman
//
//  Created by M M on 11/3/22.
//

import Foundation
import UIKit

protocol Coordinator {
    func startApplication()
}

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    let window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
        window?.makeKeyAndVisible()
    }

    func startApplication() {
        let tabBar = MainTabBarViewController()

        let loginCoordinator = LoginCoordinator(window: self.window)
        loginCoordinator.parentCoordinator = self
        loginCoordinator.openLoginVC()

        let vc = loginCoordinator.navCon

        tabBar.viewControllers = [vc]

        self.window?.rootViewController = tabBar
    }
}
