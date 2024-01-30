//
//  GFBodyLabel.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 20.01.2024.
//

import UIKit

final class GFBodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
}

extension GFBodyLabel {
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true // dynamic type
        adjustsFontSizeToFitWidth = true // dynamic type
        textColor = .secondaryLabel
        minimumScaleFactor = 0.75 // eğer metin ekrana fazla gelir ise küçültme oranı.
        lineBreakMode = .byWordWrapping
    }
}
