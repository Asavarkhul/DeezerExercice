//
//  ImageRepositoryTests.swift
//  DeezerExerciceTests
//
//  Created by Bertrand BLOC'H on 21/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import XCTest
@testable import DeezerExercice

final class ImageRepositoryTests: XCTestCase {

    func testGivenAnImageRepository_WhenSendDownloadImage_callbackIsCalled() {
        let repository = ImageRepository(networkClient: mockHTTPClient)
        let expectation = self.expectation(description: "callback block was executed")
        let cancellationToken = RequestCancellationToken()

        repository.downloadImage(for: URL(string: "https://e-cdns-images.dzcdn.net/images/cover/2e018122cb56986277102d2041a592c8/56x56-000000-80-0-0.jpg")!,
                                 cancelledBy: cancellationToken,
                                 callback: { _ in
                                    expectation.fulfill()
        })

        waitForExpectations(timeout: 1.0, handler: nil)
    }
}
