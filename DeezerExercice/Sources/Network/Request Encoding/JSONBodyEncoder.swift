//
//  JSONBodyEncoder.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 17/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

final class JSONBodyEncoder {
    
    // MARK: - Encode
    
    func encode(request: inout URLRequest, parameters: HTTPRequestParameters) throws {
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters.value)
    }
}
