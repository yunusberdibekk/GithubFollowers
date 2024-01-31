//
//  Date+Extension.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 27.01.2024.
//

import Foundation

extension Date {
//    func convertToMonthYearFormat() -> String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MMMM yyyy"
//        return dateFormatter.string(from: self)
//    }

    func convertToMonthYearFormat() -> String {
        return formatted(.dateTime.month().year())
    }
}
