//
//  ResponseModel.swift
//  Domain
//
//  Created by Quarang on 5/9/25.
//

import Foundation

// MARK: - 아이튠즈 데이터
struct ITunes {
    let id: Int
    let title: String        // trackName
    let subtitle: String     // artistName
    let imageURL: URL
    let detailURL: URL
    let genre: String
    let priceText: String    // "무료" or "₩1,100"
    let releaseDate: Date
}
