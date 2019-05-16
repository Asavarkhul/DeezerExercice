//
//  RequestCancellationToken.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 16/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

/// Object defining lifecycle of a pending HTTP request.
/// The request associated with this instance will be cancelled when the instance gets deallocated.
public class RequestCancellationToken {

    // MARK: - Lifecycle

    public init() {}

    deinit {
        willDeallocate?()
    }

    // MARK: - Internal

    internal var willDeallocate: (() -> Void)?
}
