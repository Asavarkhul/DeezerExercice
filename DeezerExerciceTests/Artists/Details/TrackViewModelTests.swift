//
//  TrackViewModelTests.swift
//  DeezerExerciceTests
//
//  Created by Bertrand BLOC'H on 22/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import XCTest
@testable import DeezerExercice

final class TrackViewModelTests: XCTestCase {

    func testGivenATrack_WhenDidConfigure_ThenAlbumTitleTextIsCorrectlyReturned() {
        let track = VisibleTrack(position: 1,
                                 title: "Sloop John B",
                                 albumTitle: "Pet Sounds",
                                 isPlaying: false)
        let delegate = MockTrackTableViewCellDelegate()
        let viewModel = TrackViewModel(with: track,
                                       at: 0,
                                       delegate: delegate)
        let expectation = self.expectation(description: "Returned text")

        viewModel.albumTitleText = { text in
            XCTAssertEqual(text, "Pet Sounds") // 😍
            expectation.fulfill()
        }

        viewModel.didConfigure()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGivenATrack_WhenDidConfigure_ThenPositionTextIsCorrectlyReturned() {
        let track = VisibleTrack(position: 1,
                                 title: "A Horse With No Name",
                                 albumTitle: "America",
                                 isPlaying: false)
        let delegate = MockTrackTableViewCellDelegate()
        let viewModel = TrackViewModel(with: track,
                                       at: 0,
                                       delegate: delegate)
        let expectation = self.expectation(description: "Returned text")
        
        viewModel.positionText = { text in
            XCTAssertEqual(text, "1")
            expectation.fulfill()
        }

        viewModel.didConfigure()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGivenATrack_WhenDidConfigure_ThenTitleTextIsCorrectlyReturned() {
        let track = VisibleTrack(position: 1,
                                 title: "Brave New World",
                                 albumTitle: "Brave New World",
                                 isPlaying: false)
        let delegate = MockTrackTableViewCellDelegate()
        let viewModel = TrackViewModel(with: track,
                                       at: 0,
                                       delegate: delegate)
        let expectation = self.expectation(description: "Returned text")
        
        viewModel.titleText = { text in
            XCTAssertEqual(text, "Brave New World")
            expectation.fulfill()
        }

        viewModel.didConfigure()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGivenAPlayingTrack_WhenDidConfigure_ThenPlayingStateIsCorrectlyReturned() {
        let track = VisibleTrack(position: 1,
                                 title: "Go Your Own Way",
                                 albumTitle: "Rumours",
                                 isPlaying: true)
        let delegate = MockTrackTableViewCellDelegate()
        let viewModel = TrackViewModel(with: track,
                                       at: 0,
                                       delegate: delegate)
        let expectation = self.expectation(description: "Returned state")
        
        viewModel.playingState = { state in
            XCTAssertEqual(state, .stop)
            expectation.fulfill()
        }
        
        viewModel.didConfigure()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGivenANotPlayingTrack_WhenDidConfigure_ThenPlayingStateIsCorrectlyReturned() {
        let track = VisibleTrack(position: 1,
                                 title: "Super Freak",
                                 albumTitle: "Street Songs",
                                 isPlaying: false)
        let delegate = MockTrackTableViewCellDelegate()
        let viewModel = TrackViewModel(with: track,
                                       at: 0,
                                       delegate: delegate)
        let expectation = self.expectation(description: "Returned state")
        
        viewModel.playingState = { state in
            XCTAssertEqual(state, .play)
            expectation.fulfill()
        }

        viewModel.didConfigure()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGivenATrack_WhenDidPressPlayStop_ThenDelegateIsCorrectlySent() {
        let track = VisibleTrack(position: 1,
                                 title: "Super Freak", // 🕺🏻
                                 albumTitle: "Street Songs",
                                 isPlaying: false)
        let delegate = MockTrackTableViewCellDelegate()
        let viewModel = TrackViewModel(with: track,
                                       at: 0,
                                       delegate: delegate)
        
        viewModel.didConfigure()

        viewModel.didPressPlayStop()

        XCTAssertEqual(delegate.index, 0)
    }
    
}

fileprivate final class MockTrackTableViewCellDelegate: TrackTableViewCellDelegate {

    var index: Int? = nil

    func trackTableViewCellDidPressPlayStop(at index: Int) {
        self.index = index
    }
}
