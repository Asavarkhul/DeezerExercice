//
//  HTTPResponse.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 16/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

final class HTTPResponse<T> {
    
    let result: Result<T>
    
    let originalData: Data?
    
    let statusCode: Int?
    
    init(result: Result<T>, originalData: Data?, statusCode: Int?) {
        self.result = result
        self.originalData = originalData
        self.statusCode = statusCode
    }
}
