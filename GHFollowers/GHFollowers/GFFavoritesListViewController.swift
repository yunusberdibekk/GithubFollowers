//
//  GFFavoritesListViewController.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 19.01.2024.
//

import UIKit

final class GFFavoritesListViewController: GFDataLoadingViewController {
    let tableView: UITableView = .init()

    var favorites: [Follower] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureTableView()
        getFavorites()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }

    private func getFavorites() {
        PersistanceManager.retrieveFavorites { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let favorites):
                updateUI(with: favorites)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }

    private func updateUI(with favorites: [Follower]) {
        if favorites.isEmpty {
            showEmptyStateView(with: "No Favorites?\nAdd one on the follower screen.", in: view)
        } else {
            self.favorites = favorites
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
}

extension GFFavoritesListViewController {
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.removeExcessCells() // tableview içindeki ekstra cell'leri silmek için.
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(GFFavoriteTableViewCell.self, forCellReuseIdentifier: GFFavoriteTableViewCell.reuseIdentifier)
    }
}

extension GFFavoritesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GFFavoriteTableViewCell.reuseIdentifier, for: indexPath) as! GFFavoriteTableViewCell
        let favorite = favorites[indexPath.row]
        cell.configure(with: favorite)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let favorite = favorites[indexPath.row]
        let destinationVC = GFFollowerListViewController(username: favorite.login)
        navigationController?.pushViewController(destinationVC, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        let favorite = favorites[indexPath.row]
        PersistanceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self else { return }
            guard let error else {
                self.favorites.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .left)
                if self.favorites.isEmpty {
                    showEmptyStateView(with: "No Favorites?\nAdd one on the follower screen.", in: self.view)
                }
                return
            }
            self.presentGFAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "Ok")
        }
    }
}
