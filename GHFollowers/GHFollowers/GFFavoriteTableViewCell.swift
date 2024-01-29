//
//  GFFavoriteTableViewCell.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 28.01.2024.
//

import UIKit

final class GFFavoriteTableViewCell: UITableViewCell {
    static let reuseIdentifier = "GFFavoriteTableViewCell"
    private let padding: CGFloat = 12

    let avatarImageView: GFAvatarImageView = .init(frame: .zero)
    let usernameLabel: GFTitleLabel = .init(textAlignment: .left, fontSize: 26)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func configure(with follower: Follower) {
        usernameLabel.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
}

extension GFFavoriteTableViewCell {
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)

        accessoryType = .disclosureIndicator

        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),

            usernameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
