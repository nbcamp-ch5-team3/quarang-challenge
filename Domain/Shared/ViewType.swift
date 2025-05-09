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
    case padcast(entity: String)
    case search(media: String, entity: String)

    var text: String {
        switch self {
        case .music: return "음악"
        case .movie: return "영화"
        case .app: return "앱"
        case .padcast: return "팟캐스트"
        case .search: return "검색"
        }
    }
}
