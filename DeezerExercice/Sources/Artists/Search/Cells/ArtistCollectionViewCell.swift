//
//  ArtistCollectionViewCell.swift
//  DeezerExercice
//
//  Created by Bertrand BLOC'H on 16/05/2019.
//  Copyright © 2019 bblch. All rights reserved.
//

import UIKit

final class ArtistCollectionViewCell: UICollectionViewCell {

    // MARK: - Outlets
    
    @IBOutlet private weak var nameLabel: UILabel!
    
    @IBOutlet private weak var coverImage: UIImageView!

    // MARK: - Private properties

    private var artist: VisibleArtist!

    private var imageProvider: ImageProvider?

    private let cancellationToken = RequestCancellationToken()

    // MARK: - Configure

    func configure(with artist: VisibleArtist, imageProvider: ImageProvider?) {
        self.artist = artist
        self.imageProvider = imageProvider
        configureCell()
    }

    private func configureCell() {
        nameLabel.text = artist.name
        guard let url = URL(string: artist.pictureURLString) else { return }
        imageProvider?.setImage(for: url, cancelledBy: cancellationToken) { [weak self] image in
            DispatchQueue.main.async {
                self?.coverImage.image = image
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 5
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.lightGray.cgColor
        nameLabel.layer.borderWidth = 0.5
        nameLabel.layer.borderColor = UIColor.lightGray.cgColor
    }

    // MARK: - View life cycle

    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        coverImage.image = nil
    }
}
