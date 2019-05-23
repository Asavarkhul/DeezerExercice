//
//  ArtistDetailsViewModel.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 17/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import Foundation

struct TrackItem: Equatable {
    let position: Int
    let title: String
    let albumTitle: String
    let previewURLString: String
    var isPlaying: Bool
}

final class ArtistDetailsViewModel {

    // MARK: - Private properties

    private let artistID: Int

    private let audioPlayer: AudioPlayer

    private let repository: ArtistDetailsRepositoryType

    private var _items: [Item] = [] {
        didSet {
            let items = _items.map { VisibleItem(item: $0) }
            visibleItems?(items)
        }
    }

    private weak var delegate: ArtistDetailsScreenDelegate?
 
    // MARK: - Properties

    enum VisibleItem: Equatable {
        case track(visibleTrack: VisibleTrack)
    }

    enum Item: Equatable {
        case track(trackItem: TrackItem)
    }

    // MARK: - Initializer

    init(artistID: Int,
         audioPlayer: AudioPlayer,
         repository: ArtistDetailsRepositoryType,
         delegate: ArtistDetailsScreenDelegate?) {
        self.artistID = artistID
        self.audioPlayer = audioPlayer
        self.repository = repository
        self.delegate = delegate

        self.audioPlayer.delegate = self
    }

    deinit {
        audioPlayer.stop()
    }

    // MARK: - Outputs

    var titleText: ((String) -> Void)?

    var visibleItems: (([VisibleItem]) -> Void)?

    // MARK: - Inputs

    func viewWillAppear() {
        repository.getFirstAlbum(for: artistID, success: { [weak self] album in
            guard let self = self else { return }
            self.titleText?(album.title)
            self._items = ArtistDetailsViewModel.initialItems(from: album)
        }, failure: { [weak self] in
            self?.delegate?.artistDetailsScreenShouldDisplayAlert(for: .networkError)
        })
    }

    func didPressPlayStop(at index: Int) {
        guard _items.count > index else {
            return
        }

        let trackItem = _items[index]
        if case .track(trackItem: let trackItem) = trackItem {
            guard let url = URL(string: trackItem.previewURLString) else { return }
            if !trackItem.isPlaying {
                self._items = ArtistDetailsViewModel.insertPlayingTrackItem(trackItem: trackItem,
                                                                            at: index,
                                                                            in: self._items)
                audioPlayer.startPlayingTrack(at: url)
            } else {
                self._items = ArtistDetailsViewModel.removePlayingTrackItems(from: self._items)
                audioPlayer.stop()
            }
        }
    }

    private class func initialItems(from album: Album) -> [Item] {
        return album.tracks.map {
            return .track(trackItem: TrackItem(position: $0.position,
                                               title: $0.title,
                                               albumTitle: album.title,
                                               previewURLString: $0.previewURLString,
                                               isPlaying: false))
        }
    }

    // MARK: - Helpers

    private class func insertPlayingTrackItem(trackItem: TrackItem, at index: Int, in trackItems: [Item]) -> [Item] {
        let startSlice = index == 0 ? [] : trackItems[0...index-1]
        var endSlice: ArraySlice<Item> = []
        if index + 1 < trackItems.count {
            endSlice = trackItems[index+1...trackItems.endIndex - 1]
        }

        var trackItem = trackItem
        trackItem.isPlaying = true

        return ArtistDetailsViewModel.removePlayingTrackItems(from: Array(startSlice))
            + [.track(trackItem: trackItem)]
            + ArtistDetailsViewModel.removePlayingTrackItems(from: Array(endSlice))
    }

    private class func removePlayingTrackItems(from items: [Item]) -> [Item] {
        return items.map { item -> Item in
            if case .track(trackItem: let trackItem) = item {
                var trackItem = trackItem
                trackItem.isPlaying = false
                return .track(trackItem: trackItem)
            } else {
                return item
            }
        }
    }
}

extension ArtistDetailsViewModel.VisibleItem {
    fileprivate init(item: ArtistDetailsViewModel.Item) {
        switch item {
        case .track(trackItem: let trackItem):
            self = .track(visibleTrack: VisibleTrack(position: trackItem.position,
                                                     title: trackItem.title,
                                                     albumTitle: trackItem.albumTitle,
                                                     isPlaying: trackItem.isPlaying))
        }
    }
}

extension ArtistDetailsViewModel: AudioPlayerDelegate {
    func playerDidFinishPlayingSound() {
        self._items = ArtistDetailsViewModel.removePlayingTrackItems(from: self._items)
    }
}
