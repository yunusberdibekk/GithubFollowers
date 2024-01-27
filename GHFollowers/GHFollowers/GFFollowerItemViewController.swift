//
//  GFFollowerItemViewController.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 27.01.2024.
//

import Foundation

final class GFFollowerItemViewController: GFItemInfoViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }

    private func configureItems() {
        itemInfoViewOne.configure(withItem: .followers, withCount: user.followers)
        itemInfoViewTwo.configure(withItem: .following, withCount: user.following)
        actionButton.configure(backgroundColor: .systemGreen, title: "Get Followers")
    }
}
