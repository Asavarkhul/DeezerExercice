//
//  AudioPlayerRepository.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 19/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

protocol AudioPlayerRepositoryType: class {
    func downloadSound(at url: URL, callback: @escaping (URL?) -> Void)
}

final class AudioPlayerRepository: AudioPlayerRepositoryType {

    // MARK: - Properties

    private let networkClient: HTTPClient

    private let cancellationToken = RequestCancellationToken()

    // MARK: - Init

    init(networkClient: HTTPClient) {
        self.networkClient = networkClient
    }

    // MARK: - AudioPlayerRepositoryType

    func downloadSound(at url: URL, callback: @escaping (URL?) -> Void) {
        let request = URLRequest(url: url)
        networkClient
            .downloadTask(request, cancelledBy: cancellationToken)
            .processDownloadResponse { (response) in
                switch response.result {
                case .success(let location):
                    callback(location)
                case .failure:
                    callback(nil)
                }
        }
    }
}
