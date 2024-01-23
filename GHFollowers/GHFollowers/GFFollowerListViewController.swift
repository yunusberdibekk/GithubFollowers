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
    var page: Int = 1

    var hasMoreFollowers: Bool = true

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    private func getFollowers(username: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers. Go follow them 😀."
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                }
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
        collectionView.delegate = self
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

extension GFFollowerListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}

/*
 UICollectionViewDiffableDataSource.
 Verileri ve section'u alıyor. Hash fonksiyonu içinde kendisi uniq id'ler veriyor.Böylece yeni verileri, eski verileri, aralardaki farkı vb.şeyleri daha iyi yapıyor. Arama özelliği ekleneceği için bunun kullanılması daha iyi. Daha dynamic.
 */
