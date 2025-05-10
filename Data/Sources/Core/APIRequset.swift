//
//  APIRequset.swift
//  Data
//
//  Created by Quarang on 5/10/25.
//

import Foundation

// MARK: API 요청 URL Request 생성
enum APIRequest {
    case iTunes(term: String, media: String, entity: String)
    case iTunesDetail(id: Int)
    
    var baseURL: URL {
        URL(string: "https://itunes.apple.com")!
    }
    
    var path: String {
        switch self {
        case .iTunes: "/search"
        case .iTunesDetail: "/lookup"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case let .iTunes(term, media, entity):
            return [
                URLQueryItem(name: "term", value: term),
                URLQueryItem(name: "country", value: "KR"),
                URLQueryItem(name: "media", value: media),
                URLQueryItem(name: "entity", value: entity),
                URLQueryItem(name: "limit", value: "20")
            ]
        case let .iTunesDetail(id):
            return [
                URLQueryItem(name: "id", value: "\(id)"),
                URLQueryItem(name: "country", value: "KR")
            ]
        }
    }
    
    var urlRequest: URLRequest {
        var components = URLComponents()
        components.scheme = "https"
        components.host = baseURL.host
        components.path = path
        components.queryItems = queryItems
        
        guard let url = components.url else { preconditionFailure("URL 존재하지 않음: \(components)") }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
