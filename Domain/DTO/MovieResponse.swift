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
    let trackViewURL: String?
    let previewURL: String?
    let artworkUrl30, artworkUrl60, artworkUrl100: String
    let collectionPrice, trackPrice: Int?
    let trackRentalPrice: Int?
    let collectionHDPrice, trackHDPrice: Int?
    let trackHDRentalPrice: Int?
    let releaseDate: String
    let collectionExplicitness, trackExplicitness: String
    let trackTimeMillis: Int
    let country: String?
    let currency: String?
    let primaryGenreName: String
    let contentAdvisoryRating: String?
    let longDescription: String
    let hasITunesExtras: Bool?
    let collectionID: Int?
    let collectionName, collectionCensoredName: String?
    let collectionArtistID: Int?
    let collectionArtistViewURL, collectionViewURL: String?
    let discCount, discNumber, trackCount, trackNumber: Int?
    let shortDescription: String?
    
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
            case releaseDate, collectionExplicitness, trackExplicitness, trackTimeMillis, country, currency, primaryGenreName, contentAdvisoryRating, longDescription, hasITunesExtras
            case collectionID = "collectionId"
            case collectionName, collectionCensoredName
            case collectionArtistID = "collectionArtistId"
            case collectionArtistViewURL = "collectionArtistViewUrl"
            case collectionViewURL = "collectionViewUrl"
            case discCount, discNumber, trackCount, trackNumber, shortDescription
        }
}

// MARK: - 뷰에서 사용할 Model로 변환
extension MovieResponse {
    public func toModel() -> ITunes {
        ITunes(
            id: trackID,
            title: trackName,
            subtitle: artistName,
            imageURL: URL(string: artworkUrl100.replacingOccurrences(of: "100x100", with: "1024x1024"))!,
            detailURL: URL(string: trackViewURL ?? "https://www.google.com/search?q=\(trackName)")!,
            genre: primaryGenreName,
            priceText: trackPrice == 0 ? "무료" : "₩\(trackPrice ?? 0)",
            releaseDate: releaseDate.toDateFromISO8601()
        )
    }
    
    public func toDetailModel() -> ITunesDetail {
        return ITunesDetail(
            id: trackID,
            title: trackName,
            subtitle: artistName,
            description: longDescription,
            artworkURL: URL(string: artworkUrl100.replacingOccurrences(of: "100x100", with: "1024x1024"))!,
            previewURL: URL(string: previewURL ?? ""),
            genre: primaryGenreName,
            releaseDate: releaseDate.toDateFromISO8601(),
            priceText: trackPrice == 0 ? "무료" : "₩\(trackPrice ?? 0)",
            contentAdvisory: contentAdvisoryRating == "explicit" ? "19.circle" : "c.circle",
            languageCodes: nil,
            screenshotURLs: [],
            sellerName: nil,
            isStreamable: nil,
            trackTimeMillis: trackTimeMillis,
            feedURL: nil,
            detailURL: URL(string: trackViewURL ?? "https://www.google.com/search?q=\(trackName)"),
            time: trackTimeMillis / 60_000,
            mediaType: .movie
        )
    }
}
