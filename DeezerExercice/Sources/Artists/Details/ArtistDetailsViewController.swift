//
//  ArtistDetailsViewController.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 14/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import UIKit

final class ArtistDetailsViewController: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Properties

    var viewModel: ArtistDetailsViewModel!

    private lazy var source = ArtistDetailsDataSource()

    // MARK: - View life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = source
        tableView.delegate = source

        bind(to: source)
        bind(to: viewModel)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.viewWillAppear()
    }

    private func bind(to source: ArtistDetailsDataSource) {
        source.didPressPlayStopAtIndex = viewModel.didPressPlayStop
    }
    
    private func bind(to viewModel: ArtistDetailsViewModel) {
        viewModel.titleText = { [weak self] title in
            self?.title = title
        }

        viewModel.visibleItems = { [weak self] visibleItems in
            self?.source.update(with: visibleItems)
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}
