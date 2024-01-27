//
//  UIViewController+Extension.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 20.01.2024.
//

import SafariServices
import UIKit

private var containerView: UIView!

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let destinationVC = GFAlertViewController(alertTitle: title, alertMessage: message, buttonTitle: buttonTitle)
            destinationVC.modalPresentationStyle = .overFullScreen
            destinationVC.modalTransitionStyle = .crossDissolve
            self.present(destinationVC, animated: true)
        }
    }

    func presentSafariVC(with url: URL) {
        DispatchQueue.main.async {
            let safariVC = SFSafariViewController(url: url)
            safariVC.preferredControlTintColor = .systemGreen
            self.present(safariVC, animated: true)
        }
    }

    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0

        UIView.animate(withDuration: 0.25) { containerView.alpha = 0.8 }

        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        ])
        activityIndicator.startAnimating()
    }

    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }

    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
