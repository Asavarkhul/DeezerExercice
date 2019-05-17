//
//  ArtistCoordinator.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 14/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import UIKit

final class ArtistCoordinator {

    // MARK: - Properties

    private let presenter: UIWindow

    private let navigationController: UINavigationController

    private let screens: Screens

    // MARK: - Initializer

    init(presenter: UIWindow, context: Context) {
        self.presenter = presenter

        self.screens = Screens(context: context)

        navigationController = UINavigationController()
    }

    // MARK: - Coordinator

    func start() {
        presenter.rootViewController = navigationController
        showSearch()
    }

    // MARK: - Artist Search

    private func showSearch() {
        let viewController = screens.createArtistSearchViewController(delegate: self)
        navigationController.viewControllers = [viewController]
    }

    // MARK: - Artist Details

    private func showDetails() {
        
    }
}

extension ArtistCoordinator: ArtistSearchScreenDelegate {
    func artistSearchScreenDidSelectArtist(for id: Int) {
        
    }
}
