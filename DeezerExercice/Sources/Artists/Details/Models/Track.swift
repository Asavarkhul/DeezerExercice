//
//  Track.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 17/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

struct Track: Codable {
    let position: Int
    let title: String
    let previewURLString: String
    
    enum CodingKeys: String, CodingKey {
        case position = "track_position"
        case title
        case previewURLString = "preview"
    }
}
