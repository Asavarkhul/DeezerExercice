//
//  AlertTests.swift
//  DeezerExerciceTests
//
//  Created by Bertrand BLOC'H on 21/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import XCTest
@testable import DeezerExercice

final class AlertTests: XCTestCase {

    func test() {
        let alert = Alert(type: .networkError)
        XCTAssertEqual(alert.title, "Alert")
        XCTAssertEqual(alert.message, "A very very bad thing happened.. 🙈")
    }
}
