//
//  CoordinatorProtocol.swift
//  FileManager
//
//  Created by M M on 1/24/23.
//

import Foundation

public protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] {get set}
}
