//
//  String+Extension.swift
//  GHFollowers
//
//  Created by Yunus Emre Berdibek on 27.01.2024.
//

import Foundation

extension String {
    func convertToDate() -> Date? {
        let dateFormater: DateFormatter = .init()
        dateFormater.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormater.locale = Locale(identifier: "en_US_POSIX")
        dateFormater.timeZone = .current
        return dateFormater.date(from: self)
    }

    func convertToDisplayFormat() -> String {
        guard let date = convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}
