//
//  GFFollowerListViewController.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 19.01.2024.
//

import UIKit

final class GFFollowerListViewController: UIViewController {
    enum Section {
        case main
    }

    var username: String!
    var followers: [Follower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
        configureDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func getFollowers() {
        NetworkManager.shared.getFollowers(for: username, page: 1) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let followers):
                self.followers = followers
                self.updateData()
            case .failure(let errorMessage):
                self.presentGFAlertOnMainThread(title: "Bad Stuff Happened", message: errorMessage.rawValue, buttonTitle: "OK")
            }
        }
    }

    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true, completion: nil)
        }
    }
}

extension GFFollowerListViewController {
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)

        collectionView.backgroundColor = .systemBackground
        collectionView.register(GFFollowerCollectionViewCell.self, forCellWithReuseIdentifier: GFFollowerCollectionViewCell.reuseIdentifier)
    }

    private func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - ((padding * 2) + (minimumItemSpacing * 2))
        let itemWidth = availableWidth / 3
        let flowLayout = UICollectionViewFlowLayout()

        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }

    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GFFollowerCollectionViewCell.reuseIdentifier, for: indexPath) as! GFFollowerCollectionViewCell
            cell.configure(with: follower)
            return cell
        })
    }
}

/*
 UICollectionViewDiffableDataSource.
 Verileri ve section'u alıyor. Hash fonksiyonu içinde kendisi uniq id'ler veriyor.Böylece yeni verileri, eski verileri, aralardaki farkı vb.şeyleri daha iyi yapıyor. Arama özelliği ekleneceği için bunun kullanılması daha iyi. Daha dynamic.
 */
