//
//  GFButton.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 19.01.2024.
//

import UIKit

final class GFButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        configure()
    }

    func configure(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
}
