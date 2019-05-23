//
//  ArtistDetailsViewModelTests.swift
//  DeezerExerciceTests
//
//  Created by Bertrand BLOC'H on 22/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import XCTest
import AVKit
@testable import DeezerExercice

final class ArtistDetailsViewModelTests: XCTestCase {

    func testGivenAnArtistDetailsViewModel_WhenViewWillAppear_ThenTitleTextIsCorrectlyReturned() {
        let album = Album(title: "Ride The Lightning", tracks: [])
        let repository = MockArtistDetailsRepository(album: album)
        let delegate = MockArtistDetailsDelegate()
        let viewModel = ArtistDetailsViewModel(artistID: 1,
                                              audioPlayer: mockAudioPlayer,
                                              repository: repository,
                                              delegate: delegate)
        let expecation = self.expectation(description: "Returned text")

        viewModel.titleText = { text in
            XCTAssertEqual(text, "Ride The Lightning")
            expecation.fulfill()
        }

        viewModel.viewWillAppear()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGivenAnArtistDetailsViewModel_WhenViewWillAppear_ThenVisibleItemsIsCorrectlyReturned() {
        let album = Album(title: "Ride The Lightning", tracks:
            [Track(position: 1, title: "Fight Fire With Fire", previewURLString: "🔥"),
            Track(position: 2, title: "Ride The Lightning", previewURLString: "⚡️"),
            Track(position: 3, title: "For Whom The Bell Tolls", previewURLString: "🔔"),
            Track(position: 4, title: "Fade To Black", previewURLString: "🏴")])
        let repository = MockArtistDetailsRepository(album: album)
        let delegate = MockArtistDetailsDelegate()
        let viewModel = ArtistDetailsViewModel(artistID: 1,
                                               audioPlayer: mockAudioPlayer,
                                               repository: repository,
                                               delegate: delegate)
        let expecation = self.expectation(description: "Returned items")

        let expectedResult: [ArtistDetailsViewModel.VisibleItem] =
            [.track(visibleTrack: VisibleTrack(position: 1,
                                               title: "Fight Fire With Fire",
                                               albumTitle: "Ride The Lightning",
                                               isPlaying: false)),
             .track(visibleTrack: VisibleTrack(position: 2,
                                               title: "Ride The Lightning",
                                               albumTitle: "Ride The Lightning",
                                               isPlaying: false)),
             .track(visibleTrack: VisibleTrack(position: 3,
                                               title: "For Whom The Bell Tolls",
                                               albumTitle: "Ride The Lightning",
                                               isPlaying: false)),
             .track(visibleTrack: VisibleTrack(position: 4,
                                               title: "Fade To Black",
                                               albumTitle: "Ride The Lightning",
                                               isPlaying: false)),]
        
        viewModel.visibleItems = { items in
            XCTAssertEqual(items, expectedResult)
            expecation.fulfill()
        }
        
        viewModel.viewWillAppear()
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGivenAnArtistDetailsViewModel_WhenViewWillAppear_WithAFailingRepositoryRequest_ThenDelegateIsCorectlySent() {
        let album = Album(title: "Ride The Lightning", tracks: [])
        let repository = MockArtistDetailsRepository(album: album)
        repository.isSuccess = false
        let delegate = MockArtistDetailsDelegate()
        let viewModel = ArtistDetailsViewModel(artistID: 1,
                                               audioPlayer: mockAudioPlayer,
                                               repository: repository,
                                               delegate: delegate)

        viewModel.viewWillAppear()

        XCTAssertEqual(delegate.alertType, .networkError)
    }

    func testGivenAnArtistDetailsViewModel_WhenDidPressPlayStopForANotPlayingTrack_ThenVisibleItemsIsCorrectlyReturned() {
        let album = Album(title: "Ride The Lightning", tracks:
            [Track(position: 1, title: "Fight Fire With Fire", previewURLString: "url"),
             Track(position: 2, title: "Ride The Lightning", previewURLString: "url"),
             Track(position: 3, title: "For Whom The Bell Tolls", previewURLString: "url"),
             Track(position: 4, title: "Fade To Black", previewURLString: "url")])
        let repository = MockArtistDetailsRepository(album: album)
        let delegate = MockArtistDetailsDelegate()
        let viewModel = ArtistDetailsViewModel(artistID: 1,
                                               audioPlayer: mockAudioPlayer,
                                               repository: repository,
                                               delegate: delegate)
        let expecation = self.expectation(description: "Returned items")
        
        let expectedResult: [ArtistDetailsViewModel.VisibleItem] =
            [.track(visibleTrack: VisibleTrack(position: 1,
                                               title: "Fight Fire With Fire",
                                               albumTitle: "Ride The Lightning",
                                               isPlaying: true)),
             .track(visibleTrack: VisibleTrack(position: 2,
                                               title: "Ride The Lightning",
                                               albumTitle: "Ride The Lightning",
                                               isPlaying: false)),
             .track(visibleTrack: VisibleTrack(position: 3,
                                               title: "For Whom The Bell Tolls",
                                               albumTitle: "Ride The Lightning",
                                               isPlaying: false)),
             .track(visibleTrack: VisibleTrack(position: 4,
                                               title: "Fade To Black",
                                               albumTitle: "Ride The Lightning",
                                               isPlaying: false)),]
        
        var counter = 0
        viewModel.visibleItems = { items in
            if counter == 1 {
                XCTAssertEqual(items, expectedResult)
                expecation.fulfill()
            }
            counter+=1
        }
        
        viewModel.viewWillAppear()

        viewModel.didPressPlayStop(at: 0)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGivenAnArtistDetailsViewModel_WhenDidPressPlayStopForAPlayingTrack_ThenVisibleItemsIsCorrectlyReturned() {
        let album = Album(title: "Ride The Lightning", tracks:
            [Track(position: 1, title: "Fight Fire With Fire", previewURLString: "url"),
             Track(position: 2, title: "Ride The Lightning", previewURLString: "url"),
             Track(position: 3, title: "For Whom The Bell Tolls", previewURLString: "url"),
             Track(position: 4, title: "Fade To Black", previewURLString: "url")])
        let repository = MockArtistDetailsRepository(album: album)
        let delegate = MockArtistDetailsDelegate()
        let viewModel = ArtistDetailsViewModel(artistID: 1,
                                               audioPlayer: mockAudioPlayer,
                                               repository: repository,
                                               delegate: delegate)
        let expecation = self.expectation(description: "Returned items")
        
        let expectedResult: [ArtistDetailsViewModel.VisibleItem] =
            [.track(visibleTrack: VisibleTrack(position: 1,
                                               title: "Fight Fire With Fire",
                                               albumTitle: "Ride The Lightning",
                                               isPlaying: false)),
             .track(visibleTrack: VisibleTrack(position: 2,
                                               title: "Ride The Lightning",
                                               albumTitle: "Ride The Lightning",
                                               isPlaying: false)),
             .track(visibleTrack: VisibleTrack(position: 3,
                                               title: "For Whom The Bell Tolls",
                                               albumTitle: "Ride The Lightning",
                                               isPlaying: false)),
             .track(visibleTrack: VisibleTrack(position: 4,
                                               title: "Fade To Black",
                                               albumTitle: "Ride The Lightning",
                                               isPlaying: false)),]

        var counter = 0
        viewModel.visibleItems = { items in
            if counter == 2 {
                XCTAssertEqual(items, expectedResult)
                expecation.fulfill()
            }
            counter+=1
        }
        
        viewModel.viewWillAppear()
        
        viewModel.didPressPlayStop(at: 0)

        viewModel.didPressPlayStop(at: 0)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGivenAnArtistDetailsViewModel_WhenDidPressPlayStopForANotPlayingTrack_AndPressPlayStopForAnotherNotPlayingTrack_ThenVisibleItemsIsCorrectlyReturned() {
        let album = Album(title: "Ride The Lightning", tracks:
            [Track(position: 1, title: "Fight Fire With Fire", previewURLString: "url"),
             Track(position: 2, title: "Ride The Lightning", previewURLString: "url"),
             Track(position: 3, title: "For Whom The Bell Tolls", previewURLString: "url"),
             Track(position: 4, title: "Fade To Black", previewURLString: "url")])
        let repository = MockArtistDetailsRepository(album: album)
        let delegate = MockArtistDetailsDelegate()
        let viewModel = ArtistDetailsViewModel(artistID: 1,
                                               audioPlayer: mockAudioPlayer,
                                               repository: repository,
                                               delegate: delegate)
        let expecation = self.expectation(description: "Returned items")
        
        let expectedResult: [ArtistDetailsViewModel.VisibleItem] =
            [.track(visibleTrack: VisibleTrack(position: 1,
                                               title: "Fight Fire With Fire",
                                               albumTitle: "Ride The Lightning",
                                               isPlaying: false)),
             .track(visibleTrack: VisibleTrack(position: 2,
                                               title: "Ride The Lightning",
                                               albumTitle: "Ride The Lightning",
                                               isPlaying: true)),
             .track(visibleTrack: VisibleTrack(position: 3,
                                               title: "For Whom The Bell Tolls",
                                               albumTitle: "Ride The Lightning",
                                               isPlaying: false)),
             .track(visibleTrack: VisibleTrack(position: 4,
                                               title: "Fade To Black",
                                               albumTitle: "Ride The Lightning",
                                               isPlaying: false)),]
        
        var counter = 0
        viewModel.visibleItems = { items in
            if counter == 2 {
                XCTAssertEqual(items, expectedResult)
                expecation.fulfill()
            }
            counter+=1
        }
        
        viewModel.viewWillAppear()
        
        viewModel.didPressPlayStop(at: 0)

        viewModel.didPressPlayStop(at: 1)
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGivenAnArtistDetailsViewModel_WhenPlayerDidFinishPlayingSound_ThenVisibleItemsIsCorrectlyReturned() {
        let album = Album(title: "Ride The Lightning", tracks:
            [Track(position: 1, title: "Fight Fire With Fire", previewURLString: "url"),
             Track(position: 2, title: "Ride The Lightning", previewURLString: "url"),
             Track(position: 3, title: "For Whom The Bell Tolls", previewURLString: "url"),
             Track(position: 4, title: "Fade To Black", previewURLString: "url")])
        let repository = MockArtistDetailsRepository(album: album)
        let delegate = MockArtistDetailsDelegate()
        let viewModel = ArtistDetailsViewModel(artistID: 1,
                                               audioPlayer: mockAudioPlayer,
                                               repository: repository,
                                               delegate: delegate)
        let expecation = self.expectation(description: "Returned items")
        
        let expectedResult: [ArtistDetailsViewModel.VisibleItem] =
            [.track(visibleTrack: VisibleTrack(position: 1,
                                               title: "Fight Fire With Fire",
                                               albumTitle: "Ride The Lightning",
                                               isPlaying: false)),
             .track(visibleTrack: VisibleTrack(position: 2,
                                               title: "Ride The Lightning",
                                               albumTitle: "Ride The Lightning",
                                               isPlaying: false)),
             .track(visibleTrack: VisibleTrack(position: 3,
                                               title: "For Whom The Bell Tolls",
                                               albumTitle: "Ride The Lightning",
                                               isPlaying: false)),
             .track(visibleTrack: VisibleTrack(position: 4,
                                               title: "Fade To Black",
                                               albumTitle: "Ride The Lightning",
                                               isPlaying: false)),]
        
        var counter = 0
        viewModel.visibleItems = { items in
            print(counter)
            if counter == 2 {
                XCTAssertEqual(items, expectedResult)
                expecation.fulfill()
            }
            counter+=1
        }
        
        viewModel.viewWillAppear()
        
        viewModel.didPressPlayStop(at: 0)
        
        viewModel.playerDidFinishPlayingSound()

        waitForExpectations(timeout: 1.0, handler: nil)
    }
}

fileprivate final class MockArtistDetailsRepository: ArtistDetailsRepositoryType {

    let album: Album

    var isSuccess = true

    init(album: Album) {
        self.album = album
    }

    func getFirstAlbum(for artistID: Int, success: @escaping (Album) -> Void, failure: @escaping (() -> Void)) {
        isSuccess ? success(album) : failure()
    }
}

fileprivate final class MockArtistDetailsDelegate: ArtistDetailsScreenDelegate {

    var alertType: AlertType? = nil

    func artistDetailsScreenShouldDisplayAlert(for type: AlertType) {
        alertType = type
    }
}
