//
//  FileManagerService.swift
//  FileManager
//
//  Created by M M on 12/21/22.
//

import Foundation

protocol FileManagerServiceProtocol {
    func contentsOfDirectory(folderURL: URL) -> [URL]?
    func createDirectory(with folderName: String, folderURL: URL)
    func createFile(with file: Data?, folderURL: URL, filename: String)
    func removeContent(url: URL)
}

class FileManagerService: FileManagerServiceProtocol {
    static let shared = FileManagerService()
    private let fileManager = FileManager.default
    let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!

    func contentsOfDirectory(folderURL: URL) -> [URL]? {
        var files: [URL] = []
        let contents = try! fileManager.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)

        for file in contents {
            files.append(file)
        }
        //why cant we just return contents?
        return files
    }

    func createDirectory(with folderName: String, folderURL: URL) {
        let url = folderURL.appending(path: folderName)
        do {
            try fileManager.createDirectory(at: url, withIntermediateDirectories: true, attributes: [:])
        } catch {
            print("Error creating folder")
        }
    }

    func createFile(with file: Data?, folderURL: URL, filename: String) {
        let url = folderURL.appending(path: generateFileName())
        fileManager.createFile(atPath: url.path(), contents: file, attributes: [:])
    }

    func removeContent(url: URL) {
        if fileManager.fileExists(atPath: url.path()) {
            do {
                try fileManager.removeItem(at: url)
            } catch {
                print("Error deleting file")
            }
        }
    }

    private func generateFileName() -> String {
        return ProcessInfo.processInfo.globallyUniqueString + ".jpg"
    }

}
