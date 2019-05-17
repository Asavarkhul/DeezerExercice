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
}

extension Screens {
    func createArtistSearchViewController(delegate: ArtistSearchScreenDelegate?) -> UIViewController {
        let viewController = artistStoryBoard.instantiateViewController(withIdentifier: "ArtistSearchViewController") as! ArtistSearchViewController
        let repository = ArtistSearchRepository(networkClient: context.networkClient)
        let viewModel = ArtistSearchViewModel(repository: repository, delegate: delegate)
        viewController.viewModel = viewModel
        viewController.imageProvider = context.imageProvider
        return viewController
    }
}

// MARK: - Details

extension Screens {
    func createArtistDetailsViewController() -> UIViewController {
        let viewController = artistStoryBoard.instantiateViewController(withIdentifier: "ArtistDetailsViewController") as! ArtistDetailsViewController
        return viewController
    }
}
