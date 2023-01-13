//
//  MainTabBarViewController.swift
//  Fileman
//
//  Created by M M on 11/10/22.
//

import Foundation
import UIKit

final class MainTabBarViewController: UITabBarController {

    private let vc = NavFactory(navCon: UINavigationController())
    //private var navCon = UINavigationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [vc.navCon]
        vc.navCon.navigationBar.isHidden = false
        vc.navCon.tabBarController?.tabBar.isHidden = true
    }
}
