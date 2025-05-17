//
//  ITunesDetail.swift
//  Domain
//
//  Created by Quarang on 5/9/25.
//

import Foundation

// MARK: - 아이튠즈 상세 정보
public struct ITunesDetail {
    public let id: Int                     // trackId
    public let title: String               // trackName
    public let subtitle: String?           // artistName or collectionName
    public let description: String?        // longDescription, description, etc.
    public let artworkURL: URL             // artworkUrl100 or artworkUrl512
    public let previewURL: URL?            // 음악, 영화 등에 있을 수 있음
    public let genre: String               // primaryGenreName
    public let releaseDate: Date           // 출시 일자
    public let priceText: String           // formattedPrice or computed text
    public let contentAdvisory: String?    // contentAdvisoryRating
    public let languageCodes: [String]?    // languageCodesISO2A
    public let screenshotURLs: [URL]       // screenshotUrls, ipadScreenshotUrls...
    public let sellerName: String?         // sellerName (앱 전용)
    public let isStreamable: Bool?         // 음악 전용
    public let trackTimeMillis: Int?       // 음악/영화 공통
    public let feedURL: URL?               // 팟캐스트 전용
    public let detailURL: URL?             // trackViewUrl
    public let time: Int?                  // 시간 -(상영시간, 트랙 재생시간)
    public let mediaType: MediaType
}
