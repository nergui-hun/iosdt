//
//  FilesCoordinator.swift
//  FileManager
//
//  Created by M M on 1/24/23.
//

import Foundation
import UIKit

final class FilesCoordinator: CoordinatorProtocol {

    weak var parentCoordinator: MainCoordinator?
    let navCon: UINavigationController
    var childCoordinators = [CoordinatorProtocol]()

    required init() {
        self.navCon = .init()
    }

    func openFolder(url: URL, title: String) {
        let filesVC: ViewController = ViewController(url: url)
        filesVC.delegate = self
        filesVC.navigationItem.title = title
        self.navCon.pushViewController(filesVC, animated: true)
    }

    func startApplication() {
        print("")
    }
}

protocol ViewControllerDelegate: AnyObject {
    func redirectToImageVC(image: UIImage)
    func openFolder(url: URL, title: String)
}

extension FilesCoordinator: ViewControllerDelegate {

    func redirectToImageVC(image: UIImage) {
        //let imageVC: ImageV
    }
}
