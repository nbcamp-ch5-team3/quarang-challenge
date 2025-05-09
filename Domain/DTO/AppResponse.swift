//
//  AppResponse.swift
//  Domain
//
//  Created by Quarang on 5/9/25.
//

import Foundation

// MARK: - 앱 정보
public struct AppResponse: Codable {
    let artistViewURL: String
    let artworkUrl60, artworkUrl100: String
    let screenshotUrls, ipadScreenshotUrls: [String]
    let appletvScreenshotUrls: [String]
    let artworkUrl512: String
    let isGameCenterEnabled: Bool
    let advisories: [String]
    let features, supportedDevices: [String]
    let kind, trackCensoredName: String
    let trackViewURL: String
    let contentAdvisoryRating: String
    let averageUserRating, averageUserRatingForCurrentVersion: Double
    let sellerURL: String?
    let languageCodesISO2A: [String]
    let fileSizeBytes, formattedPrice: String
    let userRatingCountForCurrentVersion: Int
    let trackContentRating, minimumOSVersion: String
    let artistID: Int
    let artistName: String
    let genres: [String]
    let price: Int
    let releaseDate: Date
    let trackID: Int
    let trackName: String
    let isVppDeviceBasedLicensingEnabled: Bool
    let bundleID: String
    let genreIDS: [String]
    let primaryGenreName: String
    let primaryGenreID: Int
    let sellerName: String
    let currentVersionReleaseDate: Date
    let releaseNotes, version, wrapperType, currency: String
    let description: String
    let userRatingCount: Int

    enum CodingKeys: String, CodingKey {
        case artistViewURL = "artistViewUrl"
        case artworkUrl60, artworkUrl100, screenshotUrls, ipadScreenshotUrls, appletvScreenshotUrls, artworkUrl512, isGameCenterEnabled, advisories, features, supportedDevices, kind, trackCensoredName
        case trackViewURL = "trackViewUrl"
        case contentAdvisoryRating, averageUserRating, averageUserRatingForCurrentVersion
        case sellerURL = "sellerUrl"
        case languageCodesISO2A, fileSizeBytes, formattedPrice, userRatingCountForCurrentVersion, trackContentRating
        case minimumOSVersion = "minimumOsVersion"
        case artistID = "artistId"
        case artistName, genres, price, releaseDate
        case trackID = "trackId"
        case trackName, isVppDeviceBasedLicensingEnabled
        case bundleID = "bundleId"
        case genreIDS = "genreIds"
        case primaryGenreName
        case primaryGenreID = "primaryGenreId"
        case sellerName, currentVersionReleaseDate, releaseNotes, version, wrapperType, currency, description, userRatingCount
    }
}


extension AppResponse {
    func toModel() -> ITunes {
        ITunes(
            id: trackID,
            title: trackName,
            subtitle: artistName,
            imageURL: URL(string: artworkUrl100)!,
            detailURL: URL(string: trackViewURL)!,
            genre: primaryGenreName,
            priceText: price == 0 ? "무료" : "₩\(price)",
            releaseDate: releaseDate
        )
    }
}
