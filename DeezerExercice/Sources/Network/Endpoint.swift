//
//  Endpoint.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 17/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: HTTPRequestParameters? { get }
    var timeout: TimeInterval { get }
}

extension Endpoint {
    public var timeout: TimeInterval {
        return 30
    }
}
