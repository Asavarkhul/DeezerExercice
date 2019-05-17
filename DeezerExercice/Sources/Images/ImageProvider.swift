//
//  ImageProvider.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 15/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import UIKit

typealias Key = NSString
typealias Object = NSData

final class ImageProvider {

    // MARK: - Private properties

    private let repository: ImageRepositoryType

    private var cache: NSCache<Key, Object>

    fileprivate enum CachedImage {
        case exists(data: NSData)
        case new
    }

    // MARK: - Initializer

    init(repository: ImageRepositoryType, cache: NSCache<Key, Object>) {
        self.repository = repository
        self.cache = NSCache<Key, Object>()
    }

    // MARK: - Public

    func setImage(for url: URL, cancelledBy cancellationToken: RequestCancellationToken, callback: @escaping (UIImage?) -> Void) {
        let uid = url.hashValue.description
        let cachedImage = CachedImage(with: Key(string: uid), in: cache)
        switch cachedImage {
        case .exists(data: let data):
            callback(UIImage(data: Data(referencing: data)))
        case .new:
            repository.downloadImage(for: url, cancelledBy: cancellationToken) { (data) in
                guard let data = data else { return }
                self.cache.setObject(Object(data: data), forKey: Key(string: uid))
                callback(UIImage(data: data))
            }
        }
    }
}

extension ImageProvider.CachedImage {
    init(with uid: NSString, in cache: NSCache<Key, Object>) {
        if let data = cache.object(forKey: uid) {
            self = .exists(data: data)
        } else {
            self = .new
        }
    }
}

