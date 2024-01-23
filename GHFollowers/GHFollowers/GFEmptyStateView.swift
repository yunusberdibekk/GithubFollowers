//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 23.01.2024.
//

import UIKit

final class GFEmptyStateView: UIView {
    private let messageLabel: GFTitleLabel = .init(textAlignment: .center, fontSize: 28)
    private let logoImageView: UIImageView = .init()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
}

extension GFEmptyStateView {
    private func configure() {
        addSubview(messageLabel)
        addSubview(logoImageView)

        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel

        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(resource: .emptyStateLogo)

        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),

            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 200),
            logoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40),
        ])
    }
}
