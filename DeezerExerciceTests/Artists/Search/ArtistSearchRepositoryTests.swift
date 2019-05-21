//
//  ArtistSearchRepositoryTests.swift
//  DeezerExerciceTests
//
//  Created by Bertrand BLOC'H on 21/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import XCTest
@testable import DeezerExercice

final class ArtistSearchRepositoryTests: XCTestCase {

    func testThatGetArtistsEndpointWorks() {
        let repository = ArtistSearchRepository(networkClient: mockHTTPClient,
                                                requestBuilder: mockContentRequestBuilder)
        let expectation = self.expectation(description: "Waiting for response")

        repository.getArtists(for: "Toto", success: { _ in
            expectation.fulfill()
        }, failure: {
            XCTFail()
        })

        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
