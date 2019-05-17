//
//  AppCoordinator.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 14/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import UIKit

final class AppCoordinator {
    
    // MARK: - Private properties

    private var presenter: UIWindow

    private let context: Context

    private var artistSearchCoordinator: ArtistCoordinator?
    
    // MARK: - Initializer

    init(presenter: UIWindow, context: Context) {
        self.presenter = presenter
        self.context = context
    }
    
    // MARK: - Coordinator
    func start() {
        presenter.rootViewController = UIViewController()

        if ProcessInfo.processInfo.environment["IS_RUNNING_UNIT_TESTS"] == "YES" {
            return
        }

        showSearch()
    }
    
    private func showSearch() {
        artistSearchCoordinator = ArtistCoordinator(presenter: presenter, context: context)
        artistSearchCoordinator?.start()
    }
}
