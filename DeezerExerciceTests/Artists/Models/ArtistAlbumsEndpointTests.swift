//
//  ArtistAlbumsEndpointTests.swift
//  DeezerExerciceTests
//
//  Created by Bertrand BLOC'H on 22/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import XCTest
@testable import DeezerExercice

final class ArtistAlbumsEndpointTests: XCTestCase {

    func testThatCreateCorrectlyArtistAlbumsEndpoint() {
        let endpoint = ArtistAlbumsEndpoint(artistID: 1)
        XCTAssertEqual(endpoint.method, .GET)
        XCTAssertNil(endpoint.parameters)
        XCTAssertEqual(endpoint.path, "artist/1/albums")
    }
}
