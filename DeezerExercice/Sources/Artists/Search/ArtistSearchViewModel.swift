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

    private weak var delegate: ArtistSearchScreenDelegate?

    // MARK: - Properties

    enum VisibleItem: Equatable {
        case artist(visibleArtist: VisibleArtist)
    }

    enum Item: Equatable {
        case artist(artistItem: ArtistItem)
    }

    // MARK: - Initializer

    init(repository: ArtistSearchRepositoryType, delegate: ArtistSearchScreenDelegate?) {
        self.repository = repository
        self.delegate = delegate
    }

    // MARK: - Outputs

    var searchPlaceHolder: ((String) -> Void)?

    var visibleItems: (([VisibleItem]) -> Void)?

    // MARK: - Inputs

    func viewDidLoad() {
        searchPlaceHolder?("Search an Artist name here 🤘") // This should be localized 🇫🇷
        visibleItems?([])
    }

    func didSearchArtist(with name: String) {
        let name = name.components(separatedBy: CharacterSet.letters.inverted).joined()
        repository.getArtists(for: name, success: { [weak self] artists in
            self?._items = ArtistSearchViewModel.initialItems(from: artists)
            }, failure: { [weak self] in
                self?.delegate?.artistScreenShouldDisplayAlert(for: .networkError)
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
        guard index < _items.count else {
            return
        }

        let artistItem = _items[index]
        if case .artist(artistItem: let artist) = artistItem {
            delegate?.artistSearchScreenDidSelectArtist(for: artist.id)
        }
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
