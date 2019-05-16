//
//  RequestCancellationTokenTests.swift
//  DeezerExerciceTests
//
//  Created by Bertrand BLOC'H on 16/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import XCTest
@testable import DeezerExercice

final class RequestCancellationTokenTests: XCTestCase {

    func testItExecutesBlockWhenDeallocating() {
        let expectation = self.expectation(description: "`willDeallocate` block was executed")

        autoreleasepool {
            let token = RequestCancellationToken()
            token.willDeallocate = { expectation.fulfill() }
        }

        waitForExpectations(timeout: 1, handler: nil)
    }
}
