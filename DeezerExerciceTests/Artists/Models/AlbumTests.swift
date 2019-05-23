//
//  AlbumTests.swift
//  DeezerExerciceTests
//
//  Created by Bertrand BLOC'H on 22/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import XCTest
@testable import DeezerExercice

final class AlbumTests: XCTestCase {

    func testGivenATrack_WhenInitializedWithAnAlbumTrackResponse_ItsCorrectlyInitialized() {
        let track = Track(position: 1, title: "Europa", previewURLString: "url")
        let response = AlbumTrackResponse(data: [track])
        let album = Album(title: "Santana", albumTrackResponse: response)

        XCTAssertEqual(album.title, "Santana")
        XCTAssertEqual(album.tracks.count, 1)
    }
}
