//
//  GFFollowerItemViewController.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 27.01.2024.
//

import Foundation

protocol GFFollowerItemInfoVCDelegate: AnyObject {
    func didTapGitFollowers(for user: User)
}

final class GFFollowerItemViewController: GFItemInfoViewController {
    weak var delegate: GFFollowerItemInfoVCDelegate?

    init(user: User, delegate: GFFollowerItemInfoVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    private func configureItems() {
        itemInfoViewOne.configure(withItem: .followers, withCount: user.followers)
        itemInfoViewTwo.configure(withItem: .following, withCount: user.following)
        actionButton.configure(color: .systemGreen, title: "Get Followers", systemImageName: "person.3")
    }

    override func actionButtonTapped() {
        delegate?.didTapGitFollowers(for: user)
    }
}
