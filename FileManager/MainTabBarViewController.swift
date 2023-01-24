//
//  MainTabBarViewController.swift
//  Fileman
//
//  Created by M M on 11/10/22.
//

import Foundation
import UIKit

final class MainTabBarViewController: UITabBarController {

    private let vc = NavFactory(navCon: UINavigationController(), tab: .files)
    private var settingsVC = NavFactory(navCon: UINavigationController(), tab: .settings)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setControllers()
        viewControllers = [vc.navCon, settingsVC.navCon]
    }

    private func setupView() {
        tabBar.backgroundColor = .systemGray6
        tabBar.tintColor = .systemBlue
        tabBar.isTranslucent = false
    }

    private func setControllers() {
        viewControllers = [
            vc.navCon,
            settingsVC.navCon
        ]
    }
}
