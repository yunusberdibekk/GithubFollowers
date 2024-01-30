//
//  GFTextField.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 19.01.2024.
//

import UIKit

final class GFTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor

        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12

        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        autocapitalizationType = .none
        returnKeyType = .search
        clearButtonMode = .whileEditing
        placeholder = "Enter a username"
    }
}
