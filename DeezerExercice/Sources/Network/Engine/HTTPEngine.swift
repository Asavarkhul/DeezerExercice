//
//  HTTPEngine.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 16/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

public typealias HTTPCompletionHandler = (Data?, HTTPURLResponse?, Error?) -> Void

public protocol HTTPEngine {
    func send(request: URLRequest, cancelledBy token: RequestCancellationToken, completion: @escaping HTTPCompletionHandler)
}
