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
    let feedURL: String
    let trackViewURL: String
    let artworkUrl30, artworkUrl60, artworkUrl100: String
    let collectionPrice, trackPrice, collectionHDPrice: Int
    let releaseDate: Date
    let collectionExplicitness, trackExplicitness: String
    let trackCount, trackTimeMillis: Int
    let country, currency, primaryGenreName, contentAdvisoryRating: String
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
    func toModel() -> ITunes {
        ITunes(
            id: trackID,
            title: trackName,
            subtitle: artistName,
            imageURL: URL(string: artworkUrl100)!,
            detailURL: URL(string: trackViewURL)!,
            genre: primaryGenreName,
            priceText: "무료",
            releaseDate: releaseDate
        )
    }
    
    func toDetailModel() -> ITunesDetail {
        return ITunesDetail(
            id: trackID,
            title: trackName,
            subtitle: artistName,
            description: collectionCensoredName,
            artworkURL: URL(string: artworkUrl100)!,
            previewURL: nil,
            genre: primaryGenreName,
            releaseDate: releaseDate,
            priceText: "무료",
            contentAdvisory: trackExplicitness,
            languageCodes: nil,
            screenshotURLs: [],
            sellerName: artistName,
            isStreamable: false,
            trackTimeMillis: trackTimeMillis,
            feedURL: URL(string: feedURL),
            detailURL: URL(string: trackViewURL)!,
            mediaType: .podcast
        )
    }
}
