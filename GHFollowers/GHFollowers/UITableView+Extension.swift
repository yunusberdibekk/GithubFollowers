//
//  UITableView+Extension.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 30.01.2024.
//

import UIKit

extension UITableView {
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }

    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
