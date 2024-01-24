//
//  GFUserInfoViewController.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 24.01.2024.
//

import UIKit

final class GFUserInfoViewController: UIViewController {
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        print(username)
    }

    @objc
    private func dismissVC() {
        dismiss(animated: true)
    }
}
