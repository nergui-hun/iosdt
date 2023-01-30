//
//  SettingsCoordinator.swift
//  FileManager
//
//  Created by M M on 1/24/23.
//

import Foundation
import UIKit

class SettingsCoordinator: CoordinatorProtocol {

    weak var parentCoordinator: MainCoordinator?
    let navCon: UINavigationController
    var childCoordinators = [CoordinatorProtocol]()

    required init() {
        self.navCon = .init()
    }

    func openSettingsVC() {
        let settingsVC: SettingsViewController = SettingsViewController()
        settingsVC.navigationItem.title = "Settings"
        settingsVC.delegate = self
        self.navCon.viewControllers = [settingsVC]
    }
}

protocol SettingsViewControllerDelegate: AnyObject {
    func navigateToLoginVC()
}

extension SettingsCoordinator: SettingsViewControllerDelegate {
    func navigateToLoginVC() {
        let loginVC: LoginViewController = LoginViewController(mode: .changePassword)
        self.navCon.present(loginVC, animated: true)
    }
}
