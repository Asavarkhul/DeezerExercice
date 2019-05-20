//
//  Album.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 19/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

struct Album: Codable {
    let title: String
    let tracks: [Track]
}

extension Album {
    init(title: String, albumTrackResponse: AlbumTrackResponse) {
        self.title = title
        self.tracks = albumTrackResponse.data
    }
}
