//
//  HTTPClientTests.swift
//  DeezerExerciceTests
//
//  Created by Bertrand BLOC'H on 16/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import XCTest
@testable import DeezerExercice

class HTTPClientTests: XCTestCase {

    private let cancellationToken = RequestCancellationToken()

    private let client = HTTPClient(engine: .urlSession(.default))

    func test() {
        let expectation = self.expectation(description: "received data response")
        let request = URLRequest(url: URL(string:"https://httpbin.org")!,
                                 cachePolicy: .reloadIgnoringCacheData,
                                 timeoutInterval: 4)

        retry(block: { (retry, fulfill) in
            self.client
                .executeTask(request, cancelledBy: self.cancellationToken)
                .processDataResponse(callback: { response in
                    switch response.result {
                    case .success:
                        fulfill()
                    case .failure:
                        retry()
                    }
                })
        }, untilItFulfillsExpectation: expectation, orNumberOfTimes: 3)

        waitForExpectations(timeout: 10, handler: nil)
    }

    func testu() {
        let expectation = self.expectation(description: "received codable response")
        let request = URLRequest(url: URL(string:"https://httpbin.org")!,
                                 cachePolicy: .reloadIgnoringCacheData,
                                 timeoutInterval: 4)

        struct ResponseObject: Codable {
            let json: NestedResponseObject
        }

        struct NestedResponseObject: Codable {
            let key: String
        }

        retry(block: { (retry, fulfill) in
            self.client
                .executeTask(request, cancelledBy: self.cancellationToken)
                .processCodableResponse(callback: { (response: HTTPResponse<ResponseObject>) in
                    switch response.result {
                    case .success(let object):
                        XCTAssertEqual(object.json.key, "value")
                        fulfill()
                    case .failure:
                        retry()
                    }
                })
        }, untilItFulfillsExpectation: expectation, orNumberOfTimes: 3)

        waitForExpectations(timeout: 10, handler: nil)
    }
}
