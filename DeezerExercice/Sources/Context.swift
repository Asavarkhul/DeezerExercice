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

    let requestBuilder: DZRRequestBuilder

    let imageProvider: ImageProvider

    let audioPlayer: AudioPlayer

    // MARK: - Initializer

    init(networkClient: HTTPClient, requestBuilder: DZRRequestBuilder, imageProvider: ImageProvider, audioPlayer: AudioPlayer) {
        self.networkClient = networkClient
        self.requestBuilder = requestBuilder
        self.imageProvider = imageProvider
        self.audioPlayer = audioPlayer
    }
}
