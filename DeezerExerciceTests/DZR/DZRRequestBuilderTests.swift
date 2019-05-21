//
//  DZRRequestBuilderTests.swift
//  DeezerExerciceTests
//
//  Created by Bertrand BLOC'H on 21/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import XCTest
@testable import DeezerExercice

final class DZRRequestBuilderTests: XCTestCase {

    func testThatBuildRequestCorrectly() {
        let url = URL(string: "https://api.deezer.com/")!
        let builder = DZRRequestBuilder(url: url)

        let result = builder.buildRequest(for: MockEndPoint())

        XCTAssertEqual(result?.urlComponents.path, "search")
        XCTAssertEqual(result?.method, .GET)
        XCTAssertNil(result?.parameters)
    }
}

class MockEndPoint: Endpoint {
    let path: String
    let method: HTTPMethod
    let parameters: HTTPRequestParameters?
    
    init() {
        self.path = "search"
        self.method = .GET
        self.parameters = nil
    }
}
