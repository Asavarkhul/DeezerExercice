//
//  URLSessionEngineTests.swift
//  DeezerExerciceTests
//
//  Created by Bertrand BLOC'H on 16/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import XCTest
@testable import DeezerExercice

class URLSessionEngineTests: XCTestCase {

    private let engine = URLSessionEngine()

    func testWhenSendingValidRequest_itReceivesResponse() {
        let request = URLRequest(url: URL(string: "https://httpbin.org/get")!, timeoutInterval: 4)
        let expectation = self.expectation(description: "completion is called for request: \(request.url!)")
        let token = RequestCancellationToken()

        retry(block: { (retry, fulfill) in
            self.engine.send(request: request, cancelledBy: token) { (data, response, error) in
                if data != nil, response != nil, error == nil {
                    fulfill()
                } else {
                    retry()
                }
            }
        }, untilItFulfillsExpectation: expectation, orNumberOfTimes: 3)

        waitForExpectations(timeout: 15, handler: nil)
    }

    func testWhenSendingInvalidRequest_itReceivesError() {
        let request = URLRequest(url: URL(string: "https://not-existing-resource-abcd.com/123321")!, timeoutInterval: 4)
        let expectation = self.expectation(description: "completion is called for request: \(request.url!)")
        let token = RequestCancellationToken()

        retry(block: { (retry, fulfill) in
            self.engine.send(request: request, cancelledBy: token) { (data, response, error) in
                if data == nil, response == nil, error != nil {
                    fulfill()
                } else {
                    retry()
                }
            }
        }, untilItFulfillsExpectation: expectation, orNumberOfTimes: 3)

        waitForExpectations(timeout: 15, handler: nil)
    }

    func testWhenSendingRequest_itGetsCancelled_whenCancellationTokenIsDeallocated() {
        let resource = "https://httpbin.org/delay/10" // it delays response for 10 seconds
        let request = URLRequest(url: URL(string: resource)!)
        let expectation = self.expectation(description: "completion is called for request: \(request.url!)")
        var token: RequestCancellationToken? = RequestCancellationToken()

        engine.send(request: request, cancelledBy: token!) { (data, response, error) in
            XCTAssertNil(data)
            XCTAssertNil(response)
            XCTAssertNotNil(error)

            let cancellationError = error as NSError?
            XCTAssertEqual(cancellationError?.domain, NSURLErrorDomain)
            XCTAssertEqual(cancellationError?.code, NSURLErrorCancelled)

            expectation.fulfill()
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // cancel after 2 seconds
            token = nil
        }

        waitForExpectations(timeout: 5, handler: nil) // wait 5 seconds max
    }

    func testWhenSendingTwoRequestSimultaneously_bothCanBeCancelledSeparately() {
        let resource = "https://httpbin.org/delay/10" // it delays response for 10 seconds
        let request1 = URLRequest(url: URL(string: resource)!)
        let request2 = URLRequest(url: URL(string: resource)!)
        let expectation1 = self.expectation(description: "completion is called for 1st request: \(request1.url!)")
        let expectation2 = self.expectation(description: "completion is called for 2nd request: \(request2.url!)")
        var token1: RequestCancellationToken? = RequestCancellationToken()
        var token2: RequestCancellationToken? = RequestCancellationToken()

        engine.send(request: request1, cancelledBy: token1!) { (_, _, error) in
            XCTAssertNotNil(error)
            expectation1.fulfill()
        }

        engine.send(request: request2, cancelledBy: token2!) { (_, _, error) in
            XCTAssertNotNil(error)
            expectation2.fulfill()
        }

        token1 = nil // cancel 1st request

        wait(for: [expectation1], timeout: 5) // wait for cancellation to be processed

        token2 = nil // cancel 2nd request

        waitForExpectations(timeout: 5)
    }
}
