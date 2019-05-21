//
//  MockAudioRepository.swift
//  DeezerExerciceTests
//
//  Created by Bertrand BLOC'H on 21/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

@testable import DeezerExercice
import Foundation

final class MockAudioRepository: AudioPlayerRepositoryType {

    var url: URL? = nil

    func downloadSound(at url: URL, callback: @escaping (URL?) -> Void) {
        callback(self.url)
    }
}
