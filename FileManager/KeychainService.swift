//
//  KeychainService.swift
//  FileManager
//
//  Created by M M on 1/18/23.
//

import Foundation
import KeychainAccess

protocol KeychainServiceProtocol {
    func getData(key: String) -> String?
    func saveData(value: String, key: String)
    func changeData()
}

final class KeychainService: KeychainServiceProtocol {
    
    // MARK: - Values
    static let shared = KeychainService()
    private let keychain = Keychain(service: "com.ios-18.FileManager")

    // MARK: - Methods
    func getData(key: String) -> String? {
        let token = try? keychain.getString(key)
            return token
    }

    func saveData(value: String, key: String) {
        do {
            try keychain.set(value, key: key)
        } catch let error{
            print(error.localizedDescription)
        }
    }

    func changeData() {
        print()
    }

    func removeData(key: String) {
        do {
            try keychain.remove(key)
        } catch let error {
            print(error.localizedDescription)
        }
    }

}
