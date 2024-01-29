//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 29.01.2024.
//

import UIKit

final class GFTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        UINavigationBar.appearance().tintColor = .systemGreen
        viewControllers = [createGHSearchNavigationController(), createGHFavoritesNavigationController()]
    }
}

extension GFTabBarController {
    func createGHSearchNavigationController() -> UINavigationController {
        let searchVC = GFSearchViewController()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        return UINavigationController(rootViewController: searchVC)
    }

    func createGHFavoritesNavigationController() -> UINavigationController {
        let favoritesVC = GFFavoritesViewController()
        favoritesVC.title = "Favorites"
        favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoritesVC)
    }
}
