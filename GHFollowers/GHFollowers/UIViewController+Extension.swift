//
//  UIViewController+Extension.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 20.01.2024.
//

import SafariServices
import UIKit

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
}
