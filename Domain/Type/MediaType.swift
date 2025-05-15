//
//  MediaType.swift
//  Domain
//
//  Created by Quarang on 5/9/25.
//

import Foundation

// MARK: - 미디어 타입
public enum MediaType: String {
    case app = "software", movie, music, podcast
    
    public var text: String {
        switch self {
        case .app: "앱"
        case .music: "음악"
        case .movie: "영화"
        case .podcast: "팟캐스트"
        }
    }
}
