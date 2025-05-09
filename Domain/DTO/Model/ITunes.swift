//
//  ResponseModel.swift
//  Domain
//
//  Created by Quarang on 5/9/25.
//

import Foundation

// MARK: - 아이튠즈 데이터
public struct ITunes {
    public let id: Int
    public let title: String        // trackName
    public let subtitle: String     // artistName
    public let imageURL: URL
    public let detailURL: URL
    public let genre: String
    public let priceText: String    // "무료" or "₩1,100"
    public let releaseDate: Date

    public init(
        id: Int,
        title: String,
        subtitle: String,
        imageURL: URL,
        detailURL: URL,
        genre: String,
        priceText: String,
        releaseDate: Date
    ) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        self.detailURL = detailURL
        self.genre = genre
        self.priceText = priceText
        self.releaseDate = releaseDate
    }
}
