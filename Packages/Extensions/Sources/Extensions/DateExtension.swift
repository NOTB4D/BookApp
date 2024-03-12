//
//  DateExtension.swift
//
//
//  Created by Eser Kucuker on 12.03.2024.
//

import UIKit

public extension Date {
    static func convertToDateWithTimeZone(dateString: String?) -> Date? {
        guard let dateString else { return nil }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        return dateFormatter.date(from: dateString)
    }

    func convertToString(format: String = "dd MMMM yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "tr_TR")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
