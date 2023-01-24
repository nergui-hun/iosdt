//
//  LoginCoordinator.swift
//  FileManager
//
//  Created by M M on 1/18/23.
//

import Foundation
import UIKit
import KeychainAccess

protocol LoginViewControllerDelegate: AnyObject {
    func logIn()
}

final class LoginCoordinator: CoordinatorProtocol {
    let keychain = Keychain(service: "com.ios-18.FileManager")
    weak var parentCoordinator: MainCoordinator?
    let navCon: UINavigationController
    var childCoordinators = [CoordinatorProtocol]()
    let window: UIWindow?
    private let loginInspector = LoginInspector.shared.keychain.allKeys()

    required init(window: UIWindow?) {
        self.window = window
        self.navCon = .init()
    }

    func openLoginVC() {
      //  if keychain.allKeys().isEmpty {
            let loginVC: LoginViewController = LoginViewController()
            loginVC.delegate = self
            self.navCon.pushViewController(loginVC, animated: true)
     //   }
    }

    func setTabBarController() -> UITabBarController {
        let tabBar = UITabBarController()
        let fileItem = UITabBarItem(title: "Files", image: UIImage(systemName: "folder"), tag: 0)
        let settingsItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)

        let filesCoordinator = FilesCoordinator()
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        filesCoordinator.openFolder(url: url, title: url.lastPathComponent)
        let filesVC = filesCoordinator.navCon
        filesVC.tabBarItem = fileItem
        childCoordinators.append(filesCoordinator)

        let settingsCoordinator = SettingsCoordinator()
        settingsCoordinator.openSettingsVC()
        let settingsVC = settingsCoordinator.navCon
        settingsVC.tabBarItem = settingsItem
        childCoordinators.append(settingsCoordinator)

        tabBar.viewControllers = [filesVC, settingsVC]
        return tabBar
    }
}

extension LoginCoordinator: LoginViewControllerDelegate {
    func logIn() {
        let tabBar = self.setTabBarController()
        self.window?.rootViewController = tabBar
    }
}
