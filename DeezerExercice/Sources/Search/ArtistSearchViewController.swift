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

    private lazy var source = ArtistSearchDataSource()

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
        
    }

    private func bind(to viewModel: ArtistSearchViewModel) {
        
    }

    // MARK: - Actions

}
