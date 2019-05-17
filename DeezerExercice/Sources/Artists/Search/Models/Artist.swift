//
//  Artist.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 16/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

struct Artist: Codable {
    let id: Int
    let name: String
    let pictureURLString: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case pictureURLString = "picture_medium"
    }
}
