//
//  GFRepoItemViewController.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 27.01.2024.
//

import Foundation

protocol GFRepoItemInfoVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
}

final class GFRepoItemViewController: GFItemInfoViewController {
    weak var delegate: GFRepoItemInfoVCDelegate?

    init(user: User, delegate: GFRepoItemInfoVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    private func configureItems() {
        itemInfoViewOne.configure(withItem: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.configure(withItem: .gists, withCount: user.publicGists)
        actionButton.configure(color: .systemPurple, title: "GitHub Profile", systemImageName: "person")
    }

    override func actionButtonTapped() {
        delegate?.didTapGitHubProfile(for: user)
    }
}
