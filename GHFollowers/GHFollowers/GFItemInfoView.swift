//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 27.01.2024.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}

final class GFItemInfoView: UIView {
    private let symbolImageView: UIImageView = .init()
    private let titleLabel: GFTitleLabel = .init(textAlignment: .left, fontSize: 14)
    private let countLabel: GFTitleLabel = .init(textAlignment: .center, fontSize: 14)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    func configure(withItem itemInfoType: ItemInfoType, withCount count: Int) {
        switch itemInfoType {
        case .repos:
            symbolImageView.image = SFSymbols.repos
            titleLabel.text = "Public Repos"
        case .gists:
            symbolImageView.image = SFSymbols.gists
            titleLabel.text = "Public Gists"
        case .followers:
            symbolImageView.image = SFSymbols.followers
            titleLabel.text = "Followers"
        case .following:
            symbolImageView.image = SFSymbols.following
            titleLabel.text = "Following"
        }
        countLabel.text = count.description
    }
}

extension GFItemInfoView {
    private func configure() {
        addSubviews(symbolImageView, titleLabel, countLabel)
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label

        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),

            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),

            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }
}
