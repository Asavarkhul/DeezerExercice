//
//  ArtistSearchViewModelTests.swift
//  DeezerExerciceTests
//
//  Created by Bertrand BLOC'H on 21/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import XCTest
@testable import DeezerExercice

final class ArtistSearchViewModelTests: XCTestCase {

    func testGivenAnArtistSearchViewModel_WhenViewDidLoad_ThenSearchPlaceHolderIsCorrectlyReturned() {
        let repository = MockArtistSearchRepository()
        let viewModel = ArtistSearchViewModel(repository: repository,
                                              delegate: nil)
        let expectation = self.expectation(description: "Expected text")

        viewModel.searchPlaceHolder = { text in
            XCTAssertEqual(text, "Search an Artist name here 🤘")
            expectation.fulfill()
        }

        viewModel.viewDidLoad()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGivenAnArtistSearchViewModel_WhenViewDidLoad_ThenVisibleItemsIsCorrectlyEmpty() {
        let repository = MockArtistSearchRepository()
        let viewModel = ArtistSearchViewModel(repository: repository,
                                              delegate: nil)
        let expectation = self.expectation(description: "Expected items")

        let expectedResult: [ArtistSearchViewModel.VisibleItem] = []

        viewModel.visibleItems = { items in
            XCTAssertEqual(items, expectedResult)
            expectation.fulfill()
        }

        viewModel.viewDidLoad()

        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGivenAnArtistSearchViewModel_WhenViewDidLoad_ThenVisibleItemsIsCorrectlyReturnecd() {
        let repository = MockArtistSearchRepository()
        repository.artists = [Artist(id: 1, name: "Toto", pictureURLString: "url"),
                              Artist(id: 2, name: "Iron Maiden", pictureURLString: "url")]
        let viewModel = ArtistSearchViewModel(repository: repository,
                                              delegate: nil)
        let expectation = self.expectation(description: "Expected items")
        
        let expectedResult: [ArtistSearchViewModel.VisibleItem] =
            [.artist(visibleArtist: VisibleArtist(name: "Toto",
                                                  pictureURLString: "url")),
             .artist(visibleArtist: VisibleArtist(name: "Iron Maiden",
                                                  pictureURLString: "url"))]

        var counter = 0
        viewModel.visibleItems = { items in
            if counter == 1 {
                XCTAssertEqual(items, expectedResult)
                expectation.fulfill()
            }
            counter+=1
        }
        
        viewModel.viewDidLoad()

        viewModel.didSearchArtist(with: "Toto")
        
        waitForExpectations(timeout: 1.0, handler: nil)
    }

    func testGivenAnArtistSearchViewModel_WhenDidSelectItemAtIndex_ThenDelegateIsCorrectlySent() {
        let repository = MockArtistSearchRepository()
        repository.artists = [Artist(id: 1, name: "Toto", pictureURLString: "url"),
                              Artist(id: 2, name: "Iron Maiden", pictureURLString: "url")]
        let delegate = MockArtistSearchDelegate()
        let viewModel = ArtistSearchViewModel(repository: repository,
                                              delegate: delegate)
        
        viewModel.viewDidLoad()

        viewModel.didSearchArtist(with: "Toto")

        viewModel.didSelectItem(at: 0)
        
        XCTAssertEqual(delegate.artistID, 1)
    }
}

fileprivate final class MockArtistSearchRepository: ArtistSearchRepositoryType {

    var isSuccess = true
    var artists: [Artist] = []

    func getArtists(for name: String, success: @escaping ([Artist]) -> Void, failure: @escaping (() -> Void)) {
        isSuccess ? success(artists) : failure()
    }
}

fileprivate final class MockArtistSearchDelegate: ArtistSearchScreenDelegate {

    var artistID: Int? = nil

    var alertType: AlertType? = nil
    
    func artistSearchScreenDidSelectArtist(for id: Int) {
        artistID = id
    }
    
    func artistScreenShouldDisplayAlert(for type: AlertType) {
        alertType = type
    }
}
