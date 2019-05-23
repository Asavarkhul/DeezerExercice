//
//  HTTPRequestTests.swift
//  DeezerExerciceTests
//
//  Created by Bertrand BLOC'H on 22/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import XCTest
@testable import DeezerExercice

class HTTPRequestTests: XCTestCase {
    
    func testItSetsDefaultValues() throws {
        let request = try HTTPRequest(baseURL: URL(string: "http://www.deezer.com")!,
                                      path: nil,
                                      method: .GET,
                                      parameters: nil)
        
        XCTAssertNil(request.parameters)
        XCTAssertEqual(10, request.timeout)
    }
    
    func testItThrows_whenPathIsMalformed() {
        let baseURL = URL(string: "http://www.deezer.com")!
        let malformedPath = "<>\\^`{|}"
        
        XCTAssertThrowsError(try HTTPRequest(baseURL: baseURL, path: malformedPath, method: .GET, parameters: nil)) { error in
            guard case HTTPRequestError.cannotBuildValidURL(baseURL: baseURL, path: malformedPath) = error else {
                XCTFail()
                return
            }
        }
    }
}

class HTTPMethodTests: XCTestCase {
    
    func testRawValues() {
        XCTAssertEqual("GET", HTTPMethod.GET.rawValue)
        XCTAssertEqual("HEAD", HTTPMethod.HEAD.rawValue)
        XCTAssertEqual("POST", HTTPMethod.POST.rawValue)
        XCTAssertEqual("PUT", HTTPMethod.PUT.rawValue)
        XCTAssertEqual("DELETE", HTTPMethod.DELETE.rawValue)
    }
}
