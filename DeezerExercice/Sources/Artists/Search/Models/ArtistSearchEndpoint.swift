//
//  ArtistSearchEndpoint.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 17/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

struct ArtistSearchEndpoint: Endpoint {
    let path: String
    let method: HTTPMethod
    let parameters: HTTPRequestParameters?
    
    init(name: String) {
        self.path = "search/artist?q=\(name)"
        self.method = .GET
        self.parameters = nil
    }
}
