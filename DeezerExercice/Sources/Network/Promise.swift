//
//  Promise.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 15/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

class Promise {
    
    enum Result {
        case value(Data, Int?)
        case error(Error, Data?, Int?)
    }
    
    // MARK: - Properties
    
    private var callback: ((Result) -> Void)?
    
    fileprivate var result: Result? {
        didSet {
            // Emit the signal when the result will be set to non-nil value.
            result.map(emit)
        }
    }
    
    // MARK: - Public
    
    func resolve(with value: Data, statusCode: Int?) {
        result = .value(value, statusCode)
    }
    
    func reject(with error: Error, data: Data?, statusCode: Int?) {
        result = .error(error, data, statusCode)
    }
    
    func observe(with callback: @escaping (Result) -> Void) {
        self.callback = callback
        
        // If the result has been already set, call the callback.
        result.map(emit)
    }
    
    // MARK: - Private
    
    private func emit(result: Result) {
        callback?(result)
    }
}
