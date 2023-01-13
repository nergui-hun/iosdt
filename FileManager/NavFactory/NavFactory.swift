//
//  NavFactory.swift
//  Fileman
//
//  Created by M M on 11/10/22.
//

import Foundation
import UIKit

final class NavFactory {
    let navCon: UINavigationController

    init(navCon: UINavigationController) {
        self.navCon = navCon
        startModule()
    }

    private func startModule() {
        let vc = ViewController(url: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!)
        navCon.setViewControllers([vc], animated: true)
    }
}
