//
//  Screens.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 14/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import UIKit

final class Screens {

    // MARK: - Properties

    private let artistStoryBoard = UIStoryboard(name: "Artist", bundle: Bundle(for: Screens.self))

    private let context: Context

    // MARK: - Initializer

    init(context: Context) {
        self.context = context
    }
}

// MARK: - Search

protocol ArtistSearchScreenDelegate: class {
    func artistSearchScreenDidSelectArtist(for id: Int)
    func artistScreenShouldDisplayAlert(for type: AlertType)
}

extension Screens {
    func createArtistSearchViewController(delegate: ArtistSearchScreenDelegate?) -> UIViewController {
        let viewController = artistStoryBoard.instantiateViewController(withIdentifier: "ArtistSearchViewController") as! ArtistSearchViewController
        let repository = ArtistSearchRepository(networkClient: context.networkClient, requestBuilder: context.requestBuilder)
        let viewModel = ArtistSearchViewModel(repository: repository, delegate: delegate)
        viewController.viewModel = viewModel
        viewController.imageProvider = context.imageProvider
        return viewController
    }
}

// MARK: - Details

protocol ArtistDetailsScreenDelegate: class {
    func artistDetailsScreenShouldDisplayAlert(for type: AlertType)
}

extension Screens {
    func createArtistDetailsViewController(with artistID: Int, delegate: ArtistDetailsScreenDelegate?) -> UIViewController {
        let viewController = artistStoryBoard.instantiateViewController(withIdentifier: "ArtistDetailsViewController") as! ArtistDetailsViewController
        let repository = ArtistDetailsRepository(networkClient: context.networkClient, requestBuilder: context.requestBuilder)
        let viewModel = ArtistDetailsViewModel(artistID: artistID, audioPlayer: context.audioPlayer, repository: repository, delegate: delegate)
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Alert

extension Screens {
    func createAlert(for type: AlertType) -> UIAlertController {
        let alert = Alert(type: type)
        let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(action)
        return alertController
    }
}
