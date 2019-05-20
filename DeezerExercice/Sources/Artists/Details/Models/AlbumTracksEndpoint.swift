//
//  AlbumEndpoint.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 19/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

struct AlbumTracksEndpoint: Endpoint {
    let path: String
    let method: HTTPMethod
    let parameters: HTTPRequestParameters?
    
    init(albumID: Int) {
        self.path = "album/\(albumID)/tracks"
        self.method = .GET
        self.parameters = nil
    }
}
