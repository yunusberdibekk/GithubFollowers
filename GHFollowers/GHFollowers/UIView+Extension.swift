//
//  UIView+Extension.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 27.01.2024.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) { // Variadic parameters
        views.forEach {
            addSubview($0)
        }
    }

    func pinToEdges(of superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor),
        ])
    }
}
