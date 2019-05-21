//
//  DZRRequestBuilder.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 17/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

final class DZRRequestBuilder {

    // MARK: - Private properties

    private let url: URL

    // MARK: - Initializer

    init(url: URL = URL(string: "https://api.deezer.com/")!) {
        self.url = url
    }

    // MARK: - Build request

    func buildRequest(for endpoint: Endpoint) -> HTTPRequest? {
        return try? HTTPRequest(baseURL: url,
                                path: endpoint.path,
                                method: endpoint.method,
                                parameters: endpoint.parameters,
                                timeout: endpoint.timeout)
    }
}
