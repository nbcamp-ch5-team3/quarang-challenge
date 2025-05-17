//
//  Extension+String.swift
//  Domain
//
//  Created by Quarang on 5/10/25.
//

import Foundation

extension String {
    /// 문자열 -> 날짜 (yyyy-MM-dd)
    func toDateFromISO8601() -> Date {
        let formatter = ISO8601DateFormatter()
        return formatter.date(from: self) ?? Date()
    }
}
