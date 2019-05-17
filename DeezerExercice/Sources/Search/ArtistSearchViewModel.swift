//
//  ArtistSearchViewModel.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 14/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

struct ArtistItem: Equatable {
    let id: Int
    let name: String
    let pictureURLString: String
}

final class ArtistSearchViewModel {

    // MARK: - Private properties

    private let repository: ArtistSearchRepositoryType

    private var _items: [Item] = [] {
        didSet {
            let items = _items.map { VisibleItem(item: $0) }
            visibleItems?(items)
        }
    }

    // MARK: - Properties

    enum VisibleItem: Equatable {
        case artist(visibleArtist: VisibleArtist)
    }

    enum Item: Equatable {
        case artist(artistItem: ArtistItem)
    }

    enum NextScreen: Equatable {
        case alert(title: String, message: String)
    }

    // MARK: - Initializer

    init(repository: ArtistSearchRepositoryType) {
        self.repository = repository
    }

    // MARK: - Outputs

    var visibleItems: (([VisibleItem]) -> Void)?

    var isLoading: ((Bool) -> Void)?

    var navigateTo: ((NextScreen) -> Void)?

    // MARK: - Inputs

    func viewDidLoad() {
        isLoading?(true)
        repository.getArtists(for: "toto", success: { [weak self] artists in
            self?._items = ArtistSearchViewModel.initialItems(from: artists)
            self?.isLoading?(false)
        }, failure: { [weak self] in
            self?.navigateTo?(.alert(title: "Alert", message: "A bad thing happened.. 🙈"))
            self?.isLoading?(false)
        })
    }

    private class func initialItems(from artists: [Artist]) -> [Item] {
        return artists.map {
            return .artist(artistItem: ArtistItem(id: $0.id,
                                                  name: $0.name,
                                                  pictureURLString: $0.pictureURLString))
        }
    }

    func didSelectItem(at index: Int) {
        
    }
}

extension ArtistSearchViewModel.VisibleItem {
    fileprivate init(item: ArtistSearchViewModel.Item) {
        switch item {
        case .artist(artistItem: let artistItem):
            self = .artist(visibleArtist: VisibleArtist(name: artistItem.name,
                                                        pictureURLString: artistItem.pictureURLString))
        }
    }
}
