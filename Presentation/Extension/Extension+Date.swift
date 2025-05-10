//
//  Extension+String.swift
//  Presentation
//
//  Created by Quarang on 5/10/25.
//

import Foundation

extension Date {
    func toString(format: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko_KR")
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
