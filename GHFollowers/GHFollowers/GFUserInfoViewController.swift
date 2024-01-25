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

        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong.", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }

    @objc
    private func dismissVC() {
        dismiss(animated: true)
    }
}
