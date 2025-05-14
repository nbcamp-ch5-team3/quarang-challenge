//
//  PodcastResponse.swift
//  Domain
//
//  Created by Quarang on 5/9/25.
//

import Foundation

// MARK: - 팟캐스트 정보
public struct PodcastResponse: Codable {
    let wrapperType, kind: String
    let collectionID, trackID: Int
    let artistName, collectionName, trackName, collectionCensoredName: String
    let trackCensoredName: String
    let collectionViewURL: String
    let feedURL: String?
    let trackViewURL: String?
    let artworkUrl30, artworkUrl60: String
    let artworkUrl100: String?
    let collectionPrice, trackPrice, collectionHDPrice: Int
    let releaseDate: String?
    let collectionExplicitness, trackExplicitness: String
    let trackCount: Int
    let trackTimeMillis: Int?
    let country, currency, primaryGenreName: String
    let contentAdvisoryRating: String?
    let artworkUrl600: String
    let genreIDS, genres: [String]

    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case collectionViewURL = "collectionViewUrl"
        case feedURL = "feedUrl"
        case trackViewURL = "trackViewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice
        case collectionHDPrice = "collectionHdPrice"
        case releaseDate, collectionExplicitness, trackExplicitness, trackCount, trackTimeMillis, country, currency, primaryGenreName, contentAdvisoryRating, artworkUrl600
        case genreIDS = "genreIds"
        case genres
    }
}

// MARK: - 뷰에서 사용할 Model로 변환
extension PodcastResponse {
    public func toModel() -> ITunes {
        ITunes(
            id: trackID,
            title: trackName,
            subtitle: artistName,
            imageURL: URL(string: artworkUrl100?.replacingOccurrences(of: "100x100", with: "1024x1024") ?? "")!,
            detailURL: URL(string: trackViewURL ?? "https://www.google.com/search?q=\(trackName)")!,
            genre: primaryGenreName,
            priceText: "무료",
            releaseDate: releaseDate?.toDateFromISO8601() ?? Date()
        )
    }
    
    public func toDetailModel() -> ITunesDetail {
        return ITunesDetail(
            id: trackID,
            title: trackName,
            subtitle: artistName,
            description: collectionCensoredName,
            artworkURL: URL(string: artworkUrl100?.replacingOccurrences(of: "100x100", with: "1024x1024") ?? "")!,
            previewURL: nil,
            genre: primaryGenreName,
            releaseDate: releaseDate?.toDateFromISO8601() ?? Date(),
            priceText: "무료",
            contentAdvisory: trackExplicitness,
            languageCodes: nil,
            screenshotURLs: [],
            sellerName: artistName,
            isStreamable: false,
            trackTimeMillis: trackTimeMillis,
            feedURL: URL(string: feedURL ?? ""),
            detailURL: URL(string: trackViewURL ?? "https://www.google.com/search?q=\(trackName)")!,
            mediaType: .podcast
        )
    }
}
