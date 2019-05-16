//
//  ArtistSearchViewModel.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 14/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

struct VisibleTrack: Equatable {
    
}

final class ArtistSearchViewModel {

    // MARK: - Private properties

    private let repository: ArtistSearchRepositoryType

    // MARK: - Properties

    enum Item: Equatable {
        case track(visibleTrack: VisibleTrack)
    }

    // MARK: - Initializer

    init(repository: ArtistSearchRepositoryType) {
        self.repository = repository
    }

    // MARK: - Outputs

    var isLoading: ((Bool) -> Void)?

    // MARK: - Inputs

    func viewDidLoad() {
        isLoading?(true)
        repository.getArtists(for: "Toto", success: { [weak self] artists in
            self?.isLoading?(false)
        }, failure: { [weak self] in
            self?.isLoading?(false)
        })
    }
}
