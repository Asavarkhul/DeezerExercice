//
//  ArtistSearchRepository.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 16/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation
import UIKit

protocol ArtistSearchRepositoryType {
    func getArtists(for name: String, success: @escaping ([Artist]) -> Void, failure: @escaping (() -> Void))
}

final class ArtistSearchRepository: ArtistSearchRepositoryType {
    
    // MARK: - Properties
    
    private let networkClient: HTTPClient

    private let requestBuilder: DZRRequestBuilder

    private let urlRequestBuilder = URLRequestBuilder()

    private let cancellationToken = RequestCancellationToken()
    
    // MARK: - Init
    
    init(networkClient: HTTPClient, requestBuilder: DZRRequestBuilder) {
        self.networkClient = networkClient
        self.requestBuilder = requestBuilder
    }
    
    // MARK: - ArtistSearchRepositoryType
    
    func getArtists(for name: String, success: @escaping ([Artist]) -> Void, failure: @escaping (() -> Void)) {
        let endpoint = ArtistSearchEndpoint(name: name)

        guard
            let httpRequest = self.requestBuilder.buildRequest(for: endpoint),
            let urlRequest = try? self.urlRequestBuilder.buildURLRequest(from: httpRequest)
            else { failure() ; return }
        
        networkClient
            .executeTask(urlRequest, cancelledBy: cancellationToken)
            .processCodableResponse { (response: HTTPResponse<ArtistResponse>) in
                switch response.result {
                case .success(let artistResponse):
                    success(artistResponse.artists)
                case .failure(_):
                    failure()
                }
        }
    }
}
