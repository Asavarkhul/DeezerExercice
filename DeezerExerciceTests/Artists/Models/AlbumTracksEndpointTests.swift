//
//  AlbumTracksEndpointTests.swift
//  DeezerExerciceTests
//
//  Created by Bertrand BLOC'H on 22/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import XCTest
@testable import DeezerExercice

final class AlbumTracksEndpointTests: XCTestCase {

    func testThatCreateCorrectlyAlbumTracksEndpoint() {
        let endpoint = AlbumTracksEndpoint(albumID: 1)
        XCTAssertEqual(endpoint.method, .GET)
        XCTAssertNil(endpoint.parameters)
        XCTAssertEqual(endpoint.path, "album/1/tracks")
    }
}
