//
//  ArtistSearchViewController.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 14/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import UIKit

final class ArtistSearchViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet private weak var collectionView: UICollectionView!

    // MARK: - Properties

    var viewModel: ArtistSearchViewModel!

    var imageProvider: ImageProvider!

    private lazy var source: ArtistSearchDataSource = {
        return ArtistSearchDataSource(imageProvider: imageProvider)
    }()

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = source
        collectionView.delegate = source

        bind(to: source)
        bind(to: viewModel)

        viewModel.viewDidLoad()
    }

    private func bind(to source: ArtistSearchDataSource) {
        source.didSelectItemAtIndex = viewModel.didSelectItem
    }

    private func bind(to viewModel: ArtistSearchViewModel) {
        viewModel.visibleItems = { [weak self] visibleItems in
            self?.source.update(with: visibleItems)
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }

    // MARK: - Actions

}
