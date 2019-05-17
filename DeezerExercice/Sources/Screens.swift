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

    private let storyBoard = UIStoryboard(name: "Search", bundle: Bundle(for: Screens.self))

    private let context: Context

    // MARK: - Initializer

    init(context: Context) {
        self.context = context
    }
}

// MARK: - Search

extension Screens {
    func createSearchViewController() -> UIViewController {
        let viewController = storyBoard.instantiateViewController(withIdentifier: "ArtistSearchViewController") as! ArtistSearchViewController
        let repository = ArtistSearchRepository(networkClient: context.networkClient)
        let viewModel = ArtistSearchViewModel(repository: repository)
        viewController.viewModel = viewModel
        viewController.imageProvider = context.imageProvider
        return viewController
    }
}
