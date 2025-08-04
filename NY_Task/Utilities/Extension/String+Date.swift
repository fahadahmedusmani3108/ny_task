//
//  String+Date.swift
//  NY_Task
//
//  Created by Fahad Ahmed Usmani on 04/08/2025.
//
import Foundation

extension String {
    func formatted() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        let dateOnlyFormatter = DateFormatter()
        dateOnlyFormatter.dateFormat = "yyyy-MM-dd"
        dateOnlyFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateOnlyFormatter.string(from: date)
    }
}
