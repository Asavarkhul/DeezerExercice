//
//  ArtistAlbumsEndpoint.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 17/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

struct ArtistAlbumsEndpoint: Endpoint {
    let path: String
    let method: HTTPMethod
    let parameters: HTTPRequestParameters?
    
    init(artistID: Int) {
        self.path = "artist/\(artistID)/albums"
        self.method = .GET
        self.parameters = nil
    }
}
