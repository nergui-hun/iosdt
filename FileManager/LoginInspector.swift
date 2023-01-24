//
//  LoginInspector.swift
//  FileManager
//
//  Created by M M on 1/23/23.
//

import Foundation
import KeychainAccess

final class LoginInspector {

    static let shared = LoginInspector()

    let keychain = Keychain(service: "com.ios-18.FileManager")

}
