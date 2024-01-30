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

    convenience init(color: UIColor, title: String, systemImageName: String) {
        self.init(frame: .zero)
        configure(color: color, title: title, systemImageName: systemImageName)
    }

    func configure(color: UIColor, title: String, systemImageName: String) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = .white
        configuration?.title = title
        configuration?.image = UIImage(systemName: systemImageName)
        configuration?.imagePadding = 6
        configuration?.imagePlacement = .leading
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        configuration = .filled()
        configuration?.cornerStyle = .medium
    }
}
