//
//  ArtistResponse.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 16/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

struct ArtistResponse: Codable {
    let artists: [Artist]

    enum CodingKeys: String, CodingKey {
        case artists = "data"
    }
}
