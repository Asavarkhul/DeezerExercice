//
//  AudioPlayerRepositoryTests.swift
//  DeezerExerciceTests
//
//  Created by Bertrand BLOC'H on 21/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import XCTest
@testable import DeezerExercice

final class AudioPlayerRepositoryTests: XCTestCase {

    func testGivenAnAudioPlayerRepository_WhenSendDownloadSound_callbackIsCalled() {
        let repository = AudioPlayerRepository(networkClient: mockHTTPClient)
        let expectation = self.expectation(description: "callback block was executed")

        repository.downloadSound(at: URL(string: "https://cdns-preview-d.dzcdn.net/stream/c-deda7fa9316d9e9e880d2c6207e92260-5.mp3")!, callback: { _ in
            expectation.fulfill()
        })

        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
