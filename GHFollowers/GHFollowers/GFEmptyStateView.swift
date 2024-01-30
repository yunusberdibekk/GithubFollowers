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
        addSubviews(logoImageView, messageLabel)
        configureMessageLabel()
        configureLogoView()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    convenience init(message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
}

extension GFEmptyStateView {
    private func configureLogoView() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = Images.emptyStateLogo
        let logoBottomConstant: CGFloat = DeviceTypes.isIphoneSE || DeviceTypes.isIphone8Zoomed ? 80 : 40

        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            logoImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
            logoImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: logoBottomConstant),

        ])
    }

    private func configureMessageLabel() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        let labelCenterYConstant: CGFloat = DeviceTypes.isIphoneSE || DeviceTypes.isIphone8Zoomed ? -80 : -150

        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: labelCenterYConstant),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
}
