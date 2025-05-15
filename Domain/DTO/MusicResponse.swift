//
//  MusicResponse.swift
//  Domain
//
//  Created by Quarang on 5/9/25.
//

import Foundation

// MARK: - 음악 정보
public struct MusicResponse: Codable {
    let wrapperType: String
    let kind: String
    let artistID, trackID: Int
    let collectionID: Int?
    let collectionName: String?
    let artistName, trackName: String
    let collectionCensoredName: String?
    let trackCensoredName: String
    let collectionViewURL: URL?
    let artistViewURL, trackViewURL: String
    let previewURL: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String
    let releaseDate: String
    let collectionExplicitness, trackExplicitness: String
    let discCount:Int?
    let discNumber: Int?
    let trackCount, trackNumber: Int?
    let trackTimeMillis: Int?
    let country: String
    let currency: String
    let primaryGenreName: String
    let isStreamable: Bool?
    let collectionArtistID: Int?
    let collectionArtistName, contentAdvisoryRating: String?
    let collectionHdPrice: Double?
    
    enum CodingKeys: String, CodingKey {
        case wrapperType, kind
        case artistID = "artistId"
        case collectionID = "collectionId"
        case trackID = "trackId"
        case artistName, collectionName, trackName, collectionCensoredName, trackCensoredName
        case artistViewURL = "artistViewUrl"
        case collectionViewURL = "collectionViewUrl"
        case trackViewURL = "trackViewUrl"
        case previewURL = "previewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, releaseDate, collectionExplicitness, trackExplicitness, discCount, discNumber, trackCount, trackNumber, trackTimeMillis, country, currency, primaryGenreName, isStreamable
        case collectionArtistID = "collectionArtistId"
        case collectionArtistName, contentAdvisoryRating
        case collectionHdPrice
    }
}

// MARK: - 뷰에서 사용할 Model로 변환
extension MusicResponse {
    public func toModel() -> ITunes {
        ITunes(
            id: trackID,
            title: trackName,
            subtitle: artistName,
            imageURL: URL(string: artworkUrl100.replacingOccurrences(of: "100x100", with: "1024x1024"))!,
            detailURL: URL(string: trackViewURL)!,
            genre: primaryGenreName,
            priceText: "듣기",
            releaseDate: releaseDate.toDateFromISO8601()
        )
    }
    
    public func toDetailModel() -> ITunesDetail {
        return ITunesDetail(
            id: trackID,
            title: trackName,
            subtitle: artistName,
            description: nil,
            artworkURL: URL(string: artworkUrl100.replacingOccurrences(of: "100x100", with: "1024x1024"))!,
            previewURL: URL(string: previewURL ?? "")!,
            genre: primaryGenreName,
            releaseDate: releaseDate.toDateFromISO8601(),
            priceText: "듣기",
            contentAdvisory: trackExplicitness,
            languageCodes: nil,
            screenshotURLs: [],
            sellerName: nil,
            isStreamable: isStreamable,
            trackTimeMillis: trackTimeMillis,
            feedURL: nil,
            detailURL: URL(string: trackViewURL)!,
            mediaType: .music
        )
    }
}
