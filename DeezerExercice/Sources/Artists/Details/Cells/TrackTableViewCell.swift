//
//  TrackTableViewCell.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 17/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import UIKit

protocol TrackTableViewCellDelegate: class {
    func trackTableViewCellDidPressPlayStop(at index: Int)
}

final class TrackTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet private weak var positionLabel: UILabel!

    @IBOutlet private weak var titleLabel: UILabel!

    @IBOutlet private weak var albumTitleLabel: UILabel!

    @IBOutlet private weak var playStopTrackButton: UIButton!

    private var viewModel: TrackViewModel!

    private let playImage = UIImage(named: "play")

    private let stopImage = UIImage(named: "stop")

    // MARK: - Configuration

    func configure(with viewModel: TrackViewModel) {
        self.viewModel = viewModel
        bind(to: self.viewModel)
        self.viewModel.didConfigure()
    }

    private func bind(to viewModel: TrackViewModel) {
        viewModel.titleText = { [weak self] text in
            self?.titleLabel.text = text
        }

        viewModel.albumTitleText = { [weak self] text in
            self?.albumTitleLabel.text = text
        }

        viewModel.positionText = { [weak self] text in
            self?.positionLabel.text = text
        }

        viewModel.playingState = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .play:
                self.playStopTrackButton.setImage(self.playImage, for: .normal)
            case .stop:
                self.playStopTrackButton.setImage(self.stopImage, for: .normal)
            }
        }
    }

    // MARK: - View life cycle

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        albumTitleLabel.text = nil
        positionLabel.text = nil
        playStopTrackButton.setImage(playImage, for: .normal)
    }

    // MARK: - Actions

    @IBAction func playStopTrack(_ sender: UIButton) {
        viewModel.didPressPlayStop()
    }
}
