//
//  MockImageRepository.swift
//  DeezerExerciceTests
//
//  Created by Bertrand BLOC'H on 21/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import UIKit
@testable import DeezerExercice

final class MockImageRepository: ImageRepositoryType {

    var data: Data? = nil

    func downloadImage(for url: URL,
                       cancelledBy cancellationToken: RequestCancellationToken,
                       callback: @escaping (Data?) -> Void) {
        callback(data)
    }
}
