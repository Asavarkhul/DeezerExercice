//
//  ScreensTests.swift
//  DeezerExerciceTests
//
//  Created by Bertrand BLOC'H on 21/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import XCTest
@testable import DeezerExercice

final class ScreensTests: XCTestCase {

    var context: Context!

    var screens: Screens!

    override func setUp() {
        context = Context(networkClient: mockHTTPClient,
                          requestBuilder: mockContentRequestBuilder,
                          imageProvider: mockImageProvider,
                          audioPlayer: mockAudioPlayer)
        screens = Screens(context: context)
    }

    func testThatCreateArtistSearchViewControllerCorrectly() {
        let viewController = screens.createArtistSearchViewController(delegate: nil)
        XCTAssertNotNil(viewController)
    }

    func testThatCreateArtistDetailsViewControllerCorrectly() {
        let viewController = screens.createArtistDetailsViewController(with: 0, delegate: nil)
        XCTAssertNotNil(viewController)
    }

    func testThatCreateAlertCorrectly() {
        let alertController = screens.createAlert(for: .networkError)
        XCTAssertNotNil(alertController)
    }
}
