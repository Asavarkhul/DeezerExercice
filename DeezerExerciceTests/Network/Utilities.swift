//
//  Utilities.swift
//  DeezerExerciceTests
//
//  Created by Bertrand BLOC'H on 16/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {

    /// Executes a `block` given number of times until it fulfills the `expectation`.
    ///
    /// In each execution two handlers are passed to the block:
    /// * `retry: () -> Void` handler - should be called if the execution is not fulfilling the expectation;
    /// * `fulfill: () -> Void` handler - should be called if the execution is fulfilling the expectation.
    ///
    /// - Parameters:
    ///   - block: the block to repeat
    ///   - expectation: the expectation to fulfill in block's positive execution
    ///   - attempts: maximum number of attempts
    func retry(block: @escaping (@escaping () -> Void, @escaping () -> Void) -> Void, untilItFulfillsExpectation expectation: XCTestExpectation, orNumberOfTimes attempts: Int) {
        if attempts == 0 {
            return
        }

        let retry = {
            self.retry(block: block, untilItFulfillsExpectation: expectation, orNumberOfTimes: (attempts - 1))
        }

        let fulfill = {
            expectation.fulfill()
        }

        block(retry, fulfill)
    }
}
