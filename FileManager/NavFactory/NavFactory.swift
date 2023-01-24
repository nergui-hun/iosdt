//
//  NavFactory.swift
//  Fileman
//
//  Created by M M on 11/10/22.
//

import Foundation
import UIKit

final class NavFactory {
    enum Tab {
        case files
        case settings
    }

    let navCon: UINavigationController
    let tab: Tab

    init(navCon: UINavigationController, tab: Tab) {
        self.navCon = navCon
        self.tab = tab
        startModule()
    }

    private func startModule() {
        switch tab {
        case .files:
            let vc = ViewController(url: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!)
            navCon.tabBarItem.title = "Files"
            navCon.setViewControllers([vc], animated: true)

        case .settings:
            let settingsVC = SettingsViewController()
            navCon.tabBarItem.title = "Settings"
            navCon.setViewControllers([settingsVC], animated: true)
        }
    }
}
