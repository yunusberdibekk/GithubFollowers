//
//  GFUserInfoViewController.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 24.01.2024.
//

import SafariServices
import UIKit

protocol GFUserInfoVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
    func didTapGitFollowers(for user: User)
}

final class GFUserInfoViewController: UIViewController {
    private let username: String
    weak var delegate: GFFollowerListVCDelegate?

    private let headerView = UIView()
    private let itemViewOne = UIView()
    private let itemViewTwo = UIView()
    private let dateLabel: GFBodyLabel = .init(textAlignment: .center)

    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUserInfo()
    }

    @objc
    private func dismissVC() {
        dismiss(animated: true)
    }

    private func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong.", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}

extension GFUserInfoViewController {
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    }

    private func configureUIElements(with user: User) {
        let repoItemVC = GFRepoItemViewController(user: user)
        repoItemVC.delegate = self
        let followerItemVC = GFFollowerItemViewController(user: user)
        followerItemVC.delegate = self

        add(childVC: GFUserInfoHeaderViewController(user: user), to: headerView)
        add(childVC: repoItemVC, to: itemViewOne)
        add(childVC: followerItemVC, to: itemViewTwo)
        dateLabel.text = "GitHub since \(user.createdAt.convertToDisplayFormat())"
    }

    private func layoutUI() {
        view.addSubviews(headerView, itemViewOne, itemViewTwo, dateLabel)

        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false

        let padding: CGFloat = 20.0
        let itemHeight: CGFloat = 140

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            headerView.heightAnchor.constraint(equalToConstant: 180),

            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),

            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),

            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
        ])
    }

    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}

extension GFUserInfoViewController: GFUserInfoVCDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: "Ok")
            return
        }
        presentSafariVC(with: url)
    }

    func didTapGitFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No Followers", message: "This user has no followers. What a shame 😊", buttonTitle: "Ok")
            return
        }
        delegate?.didRequestFollowers(for: user.login)
        dismissVC()
    }
}
