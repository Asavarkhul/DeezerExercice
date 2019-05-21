//
//  MockFileManager.swift
//  DeezerExerciceTests
//
//  Created by Bertrand BLOC'H on 21/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

@testable import DeezerExercice
import Foundation

final class MockFileManager: FileManagerType {

    var urls: [URL] = []

    func fileExists(atPath path: String) -> Bool {
        return urls.contains(URL(fileURLWithPath: path).deletingLastPathComponent())
    }
    
    func urls(for directory: FileManager.SearchPathDirectory, in domainMask: FileManager.SearchPathDomainMask) -> [URL] {
        return urls
    }
    
    func moveItem(at srcURL: URL, to dstURL: URL) throws {
        urls = [srcURL.deletingLastPathComponent()]
    }
}
