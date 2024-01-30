//
//  GFSecondaryTitleLabel.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 27.01.2024.
//

import UIKit

final class GFSecondaryTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
}

extension GFSecondaryTitleLabel {
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        lineBreakMode = .byTruncatingTail
    }
}
