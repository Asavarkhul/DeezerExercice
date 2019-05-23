//
//  ArtistDetailsRepositoryTests.swift
//  DeezerExerciceTests
//
//  Created by Bertrand BLOC'H on 22/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import XCTest
@testable import DeezerExercice

final class ArtistDetailsRepositoryTests: XCTestCase {

    func testThatGetFirstAlbumEndpointWorks() {
        let repository = ArtistDetailsRepository(networkClient: mockHTTPClient,
                                                 requestBuilder: mockContentRequestBuilder)
        let expectation = self.expectation(description: "Waiting for response")

        repository.getFirstAlbum(for: 103248, success: { _ in
            expectation.fulfill()
        }, failure: {
            XCTFail()
        })

        waitForExpectations(timeout: 10.0, handler: nil)
    }
}
