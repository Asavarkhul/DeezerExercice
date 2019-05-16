//
//  ArtistSearchRepository.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 16/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

protocol ArtistSearchRepositoryType {
    func getArtists(for name: String, success: @escaping ([Artist]) -> Void, failure: @escaping (() -> Void))
}

final class ArtistSearchRepository: ArtistSearchRepositoryType {
    
    // MARK: - Properties
    
    private let networkClient: HTTPClient
    
    private let cancellationToken = RequestCancellationToken()
    
    // MARK: - Init
    
    init(networkClient: HTTPClient) {
        self.networkClient = networkClient
    }
    
    // MARK: - ArtistRepositoryType
    
    func getArtists(for name: String, success: @escaping ([Artist]) -> Void, failure: @escaping (() -> Void)) {

        let request = URLRequest(url: URL(string: "https://api.deezer.com/search/artist?q=\(name)")!)
        
        networkClient
            .executeTask(request, cancelledBy: cancellationToken)
            .processCodableResponse { (response: HTTPResponse<ArtistInfos>) in
                switch response.result {
                case .success( let artistInfos):
                    success(artistInfos.data)
                case .failure(_):
                    failure()
                }
        }
    }
}
