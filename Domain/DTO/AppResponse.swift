//
//  AppResponse.swift
//  Domain
//
//  Created by Quarang on 5/9/25.
//

import Foundation

// MARK: - 앱 정보
public struct AppResponse: Codable {
    let isGameCenterEnabled: Bool
    let artistViewURL: String
    let artworkUrl30: String?
    let artworkUrl60: String
    let artworkUrl100: String?
    let screenshotUrls, ipadScreenshotUrls, appletvScreenshotUrls: [String]
    let artworkUrl512: String
    let features: [String]
    let supportedDevices: [String]
    let advisories: [String]
    let kind: String
    let averageUserRatingForCurrentVersion: Double
    let minimumOSVersion: String
    let userRatingCountForCurrentVersion: Int
    let trackContentRating, trackCensoredName: String
    let trackViewURL: String?
    let contentAdvisoryRating: String?
    let averageUserRating: Double
    let sellerURL: String?
    let languageCodesISO2A: [String]
    let fileSizeBytes, formattedPrice: String
    let artistID: Int
    let artistName: String
    let genres: [String]
    let price: Int
    let bundleID: String
    let genreIDS: [String]
    let releaseDate: String?
    let primaryGenreName: String
    let primaryGenreID: Int
    let isVppDeviceBasedLicensingEnabled: Bool
    let sellerName: String
    let currentVersionReleaseDate: String
    let releaseNotes, version, wrapperType, currency: String?
    let description: String?
    let trackID: Int
    let trackName: String
    let userRatingCount: Int
    
    enum CodingKeys: String, CodingKey {
        case isGameCenterEnabled
        case artistViewURL = "artistViewUrl"
        case artworkUrl30, artworkUrl60, artworkUrl100, screenshotUrls, ipadScreenshotUrls, appletvScreenshotUrls, artworkUrl512, features, supportedDevices, advisories, kind, averageUserRatingForCurrentVersion
        case minimumOSVersion = "minimumOsVersion"
        case userRatingCountForCurrentVersion, trackContentRating, trackCensoredName
        case trackViewURL = "trackViewUrl"
        case contentAdvisoryRating, averageUserRating
        case sellerURL = "sellerUrl"
        case languageCodesISO2A, fileSizeBytes, formattedPrice
        case artistID = "artistId"
        case artistName, genres, price
        case bundleID = "bundleId"
        case genreIDS = "genreIds"
        case releaseDate, primaryGenreName
        case primaryGenreID = "primaryGenreId"
        case isVppDeviceBasedLicensingEnabled, sellerName, currentVersionReleaseDate, releaseNotes, version, wrapperType, currency, description
        case trackID = "trackId"
        case trackName, userRatingCount
    }
}

// MARK: - 뷰에서 사용할 Model로 변환
extension AppResponse {
    public func toModel() -> ITunes {
        ITunes(
            id: trackID,
            title: trackName,
            subtitle: artistName,
            imageURL: URL(string: artworkUrl100?.replacingOccurrences(of: "100x100", with: "1024x1024") ?? "")!,
            detailURL: URL(string: trackViewURL ?? "https://www.google.com/search?q=\(trackName)")!,
            genre: primaryGenreName,
            priceText: price == 0 ? "무료" : "₩\(price)",
            releaseDate: releaseDate?.toDateFromISO8601() ?? Date()
        )
    }
    
    public func toDetailModel() -> ITunesDetail {
        return ITunesDetail(
            id: trackID,
            title: trackName,
            subtitle: artistName,
            description: description,
            artworkURL: URL(string: artworkUrl100?.replacingOccurrences(of: "100x100", with: "1024x1024") ?? "")!,
            previewURL: nil,
            genre: primaryGenreName,
            releaseDate: releaseDate?.toDateFromISO8601() ?? Date(),
            priceText: formattedPrice,
            contentAdvisory: contentAdvisoryRating == "17+" ? "19.circle" : "c.circle",
            languageCodes: languageCodesISO2A,
            screenshotURLs: screenshotUrls.compactMap { URL(string: $0) },
            sellerName: sellerName,
            isStreamable: nil,
            trackTimeMillis: nil,
            feedURL: nil,
            detailURL: URL(string: trackViewURL ?? "https://www.google.com/search?q=\(trackName)"),
            time: nil,
            mediaType: .app
        )
    }
}
