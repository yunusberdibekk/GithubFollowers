//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 22.01.2024.
//

import UIKit

final class GFAvatarImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }
}

extension GFAvatarImageView {
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds = true
        image = Images.placeholder
    }
}
