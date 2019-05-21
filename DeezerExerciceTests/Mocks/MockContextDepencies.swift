//
//  MockContextDepencies.swift
//  DeezerExerciceTests
//
//  Created by Bertrand BLOC'H on 21/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

@testable import DeezerExercice
import Foundation

var mockHTTPClient: HTTPClient {
    return HTTPClient(engine: .urlSession(.default))
}

var mockContentRequestBuilder: DZRRequestBuilder {
    return DZRRequestBuilder(url: URL(string: "https://api.deezer.com/")!)
}

var mockAudioPlayer: AudioPlayer {
    return AudioPlayer(repository: MockAudioRepository(),
                       fileManager: MockFileManager())
}

var mockImageProvider: ImageProvider {
    return ImageProvider(repository: MockImageRepository(),
                         cache: NSCache<Key, Object>())
}


