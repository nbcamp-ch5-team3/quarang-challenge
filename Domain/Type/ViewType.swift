//
//  ViewType.swift
//  Presentation
//
//  Created by Quarang on 5/9/25.
//

import Foundation

// MARK: - 뷰 타입
public enum ViewType {
    case music(attributes: String)
    case movie(attributes: String)
    case app(attributes: String)
    case podcast(attributes: String)
    case search(media: MediaType, attributes: String)

    public var text: String {
        switch self {
        case .music: return "음악"
        case .movie: return "영화"
        case .app: return "앱"
        case .podcast: return "팟캐스트"
        case .search: return "검색"
        }
    }
    
    public var image: String {
        switch self {
        case .music: return "music.note"
        case .movie: return "film.fill"
        case .app: return "square.3.layers.3d.top.filled"
        case .podcast: return "mic.fill"
        case .search: return "magnifyingglass"
        }
    }
    
    public var tag: Int {
        switch self {
        case .music: 1
        case .movie: 2
        case .app: 3
        case .podcast: 4
        case .search: 5
        }
    }
    
    public var type: MediaType {
        switch self {
        case .music: .music
        case .movie: .movie
        case .app: .app
        case .podcast: .podcast
        case let .search(media, _): media
        }
    }
}
