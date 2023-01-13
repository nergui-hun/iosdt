//
//  MainCoordinator.swift
//  Fileman
//
//  Created by M M on 11/3/22.
//

import Foundation
import UIKit

protocol Coordinator {
    func startApplication() -> UIViewController
}
class MainCoordinator: Coordinator {
    func startApplication() -> UIViewController {
        MainTabBarViewController()
    }
}
