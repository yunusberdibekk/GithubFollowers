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
}
