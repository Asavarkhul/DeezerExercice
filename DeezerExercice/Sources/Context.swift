//
//  Context.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 16/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

final class Context {

    // MARK: - Public properties

    let networkClient: HTTPClient

    let imageProvider: ImageProvider

    // MARK: - Initializer

    init(networkClient: HTTPClient, imageProvider: ImageProvider) {
        self.networkClient = networkClient
        self.imageProvider = imageProvider
    }
}
