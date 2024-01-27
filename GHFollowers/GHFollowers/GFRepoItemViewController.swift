//
//  GFRepoItemViewController.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 27.01.2024.
//

import Foundation

final class GFRepoItemViewController: GFItemInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    private func configureItems() {
        itemInfoViewOne.configure(withItem: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.configure(withItem: .gists, withCount: user.publicGists)
        actionButton.configure(backgroundColor: .systemPurple, title: "GitHub Profile")
    }

    override func actionButtonTapped() {
        delegate?.didTapGitHubProfile(for: user)
    }
}
