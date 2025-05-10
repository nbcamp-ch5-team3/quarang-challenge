//
//  MusicResponse.swift
//  Domain
//
//  Created by Quarang on 5/9/25.
//

import Foundation

// MARK: - 음악 정보
public struct MusicResponse: Codable {
    let wrapperType, kind: String
    let artistID, collectionID, trackID: Int
    let artistName, collectionName, trackName, collectionCensoredName: String
    let trackCensoredName: String
    let artistViewURL, collectionViewURL, trackViewURL: String
    let previewURL: String
    let artworkUrl30, artworkUrl60, artworkUrl100: String
    let releaseDate: Date
    let collectionExplicitness, trackExplicitness: String
    let discCount, discNumber, trackCount, trackNumber: Int
    let trackTimeMillis: Int
    let country, currency, primaryGenreName: String
    let isStreamable: Bool

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
    }
}

// MARK: - 뷰에서 사용할 Model로 변환
extension MusicResponse {
    func toModel() -> ITunes {
        ITunes(
            id: trackID,
            title: trackName,
            subtitle: artistName,
            imageURL: URL(string: artworkUrl100)!,
            detailURL: URL(string: trackViewURL)!,
            genre: primaryGenreName,
            priceText: "",
            releaseDate: releaseDate
        )
    }
    
    func toDetailModel() -> ITunesDetail {
        return ITunesDetail(
            id: trackID,
            title: trackName,
            subtitle: artistName,
            description: nil,
            artworkURL: URL(string: artworkUrl100)!,
            previewURL: URL(string: previewURL),
            genre: primaryGenreName,
            releaseDate: releaseDate,
            priceText: "무료",
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
