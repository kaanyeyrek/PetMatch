//
//  Extension.swift
//  PetMatch
//
//  Created by Kaan Yeyrek on 11/6/22.
//

import Foundation


// Date format ex
extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter
    }()
}
extension String {
    static func date(with date: Date) -> String {
        return DateFormatter.dateFormatter.string(from: date)
        }
    }




