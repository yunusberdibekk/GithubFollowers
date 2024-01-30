//
//  GFFollowerCollectionViewCell.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 22.01.2024.
//

import UIKit

final class GFFollowerCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "GFFollowerCollectionViewCell"
    private let padding: CGFloat = 8

    let avatarImageView: GFAvatarImageView = .init(frame: .zero)
    let usernameLabel: GFTitleLabel = .init(textAlignment: .center, fontSize: 16)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func configure(with follower: Follower) {
        usernameLabel.text = follower.login
        avatarImageView.downloadImage(fromURL: follower.avatarUrl)
    }
}

extension GFFollowerCollectionViewCell {
    private func configure() {
        addSubviews(avatarImageView, usernameLabel)

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),

            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
