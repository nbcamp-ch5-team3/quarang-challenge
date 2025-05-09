//
//  ViewType.swift
//  Presentation
//
//  Created by Quarang on 5/9/25.
//

import Foundation

// MARK: - 뷰 타입
public enum ViewType {
    case music(entity: String)
    case movie(entity: String)
    case app(entity: String)
    case podcast(entity: String)
    case search(media: String, entity: String)

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
}
