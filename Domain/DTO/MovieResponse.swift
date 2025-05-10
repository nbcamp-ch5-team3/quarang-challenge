//
//  MovieResponse.swift
//  Domain
//
//  Created by Quarang on 5/9/25.
//

import Foundation

// MARK: - 영화 정보
public struct MovieResponse: Codable {
    let wrapperType, kind: String
    let trackID: Int
    let artistName, trackName, trackCensoredName: String
    let trackViewURL: String
    let previewURL: String
    let artworkUrl30, artworkUrl60, artworkUrl100: String
    let collectionPrice, trackPrice, trackRentalPrice, collectionHDPrice: Int
    let trackHDPrice, trackHDRentalPrice: Int
    let releaseDate: Date
    let collectionExplicitness, trackExplicitness: String
    let trackTimeMillis: Int
    let country, currency, primaryGenreName, contentAdvisoryRating: String
    let shortDescription, longDescription: String
    
    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case trackID = "trackId"
        case artistName, trackName, trackCensoredName
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, collectionPrice, trackPrice, trackRentalPrice
        case collectionHDPrice = "collectionHdPrice"
        case trackHDPrice = "trackHdPrice"
        case trackHDRentalPrice = "trackHdRentalPrice"
        case releaseDate, collectionExplicitness, trackExplicitness, trackTimeMillis, country, currency, primaryGenreName, contentAdvisoryRating, shortDescription, longDescription
    }
}

// MARK: - 뷰에서 사용할 Model로 변환
extension MovieResponse {
    public func toModel() -> ITunes {
        ITunes(
            id: trackID,
            title: trackName,
            subtitle: artistName,
            imageURL: URL(string: artworkUrl100)!,
            detailURL: URL(string: trackViewURL)!,
            genre: primaryGenreName,
            priceText: "₩\(trackPrice)",
            releaseDate: releaseDate
        )
    }
    
    public func toDetailModel() -> ITunesDetail {
        return ITunesDetail(
            id: trackID,
            title: trackName,
            subtitle: artistName,
            description: longDescription,
            artworkURL: URL(string: artworkUrl100)!,
            previewURL: URL(string: previewURL),
            genre: primaryGenreName,
            releaseDate: releaseDate,
            priceText: "₩\(trackPrice)",
            contentAdvisory: contentAdvisoryRating,
            languageCodes: nil,
            screenshotURLs: [],
            sellerName: nil,
            isStreamable: nil,
            trackTimeMillis: trackTimeMillis,
            feedURL: nil,
            detailURL: URL(string: trackViewURL)!,
            mediaType: .movie
        )
    }
}
