//
//  Extension+ViewType.swift
//  Presentation
//
//  Created by Quarang on 5/14/25.
//

import Foundation
import Domain

// MARK: - 타입 별 카테고리리스트를 반환하기 위한 확장
extension ViewType {
    var entityEnum: [ITunesEntity] {
        switch self {
        case .music: MusicEntity.allCases.map { ITunesEntity(entity: $0.rawValue, label: $0.label, image: $0.image) }
        case .movie: MovieEntity.allCases.map { ITunesEntity(entity: $0.rawValue, label: $0.label, image: $0.image) }
        case .app: AppEntity.allCases.map { ITunesEntity(entity: $0.rawValue, label: $0.label, image: $0.image) }
        case .podcast: PodcastEntity.allCases.map { ITunesEntity(entity: $0.rawValue, label: $0.label, image: $0.image) }
        case let .search(media, _):
            switch media {
            case .app: AppEntity.allCases.map { ITunesEntity(entity: $0.rawValue, label: $0.label, image: $0.image) }
            case .movie: MovieEntity.allCases.map { ITunesEntity(entity: $0.rawValue, label: $0.label, image: $0.image) }
            case .music: MusicEntity.allCases.map { ITunesEntity(entity: $0.rawValue, label: $0.label, image: $0.image) }
            case .podcast: PodcastEntity.allCases.map { ITunesEntity(entity: $0.rawValue, label: $0.label, image: $0.image) }
            }
        }
    }
    
    static var allCases: [ViewType] {
        [
            .music(entity: "music"),
            .movie(entity: "movie"),
            .app(entity: "app"),
            .podcast(entity: "podcast"),
            .search(media: .music, entity: "search")
        ]
    }
}

// MARK: 변환 타입
struct ITunesEntity: Equatable {
    let entity: String
    let label: String
    let image: String
}

// MARK: 뮤직 타입
enum MusicEntity: String, CaseIterable {
    case all, songTerm, mixTerm, genreIndex, artistTerm, composerTerm, albumTerm, ratingIndex

    var label: String {
        switch self {
        case .all: return "전체"
        case .songTerm: return "노래"
        case .mixTerm: return "믹스"
        case .genreIndex: return "장르"
        case .artistTerm: return "아티스트"
        case .composerTerm: return "작곡가"
        case .albumTerm: return "앨범"
        case .ratingIndex: return "평점"
        }
    }

    var image: String {
        switch self {
        case .all: return "✨"
        case .songTerm: return "🎵"
        case .mixTerm: return "🎶"
        case .genreIndex: return "📚"
        case .artistTerm: return "🎤"
        case .composerTerm: return "🧑‍🎼"
        case .albumTerm: return "💿"
        case .ratingIndex: return "⭐️"
        }
    }
}

// MARK: 영화 타입
enum MovieEntity: String, CaseIterable {
    case all, actorTerm, genreIndex, artistTerm, shortFilmTerm, producerTerm, ratingTerm, directorTerm, releaseYearTerm, featureFilmTerm, movieArtistTerm, movieTerm, ratingIndex, descriptionTerm

    var label: String {
        switch self {
        case .all: return "전체"
        case .actorTerm: return "배우"
        case .genreIndex: return "장르"
        case .artistTerm: return "아티스트"
        case .shortFilmTerm: return "단편"
        case .producerTerm: return "제작자"
        case .ratingTerm: return "등급"
        case .directorTerm: return "감독"
        case .releaseYearTerm: return "개봉연도"
        case .featureFilmTerm: return "장편"
        case .movieArtistTerm: return "영화 아티스트"
        case .movieTerm: return "영화"
        case .ratingIndex: return "평점"
        case .descriptionTerm: return "설명"
        }
    }

    var image: String {
        switch self {
        case .all: return "✨"
        case .actorTerm: return "🎭"
        case .genreIndex: return "📚"
        case .artistTerm: return "🎤"
        case .shortFilmTerm: return "🎬"
        case .producerTerm: return "🎞"
        case .ratingTerm: return "🔢"
        case .directorTerm: return "🎬"
        case .releaseYearTerm: return "🗓"
        case .featureFilmTerm: return "🎥"
        case .movieArtistTerm: return "🧑‍🎨"
        case .movieTerm: return "🎞"
        case .ratingIndex: return "⭐️"
        case .descriptionTerm: return "📝"
        }
    }
}

// MARK: 앱 타입
enum AppEntity: String, CaseIterable {
    case all, softwareDeveloper

    var label: String {
        switch self {
        case .all: return "전체"
        case .softwareDeveloper: return "개발자"
        }
    }

    var image: String {
        switch self {
        case .all: return "✨"
        case .softwareDeveloper: return "👨‍💻"
        }
    }
}

// MARK: 팟캐스트 타입
enum PodcastEntity: String, CaseIterable {
    case all, titleTerm, languageTerm, authorTerm, genreIndex, artistTerm, ratingIndex, keywordsTerm, descriptionTerm

    var label: String {
        switch self {
        case .all: return "전체"
        case .titleTerm: return "제목"
        case .languageTerm: return "언어"
        case .authorTerm: return "작가"
        case .genreIndex: return "장르"
        case .artistTerm: return "아티스트"
        case .ratingIndex: return "평점"
        case .keywordsTerm: return "키워드"
        case .descriptionTerm: return "설명"
        }
    }

    var image: String {
        switch self {
        case .all: return "✨"
        case .titleTerm: return "🔤"
        case .languageTerm: return "🗣"
        case .authorTerm: return "📝"
        case .genreIndex: return "📚"
        case .artistTerm: return "🎤"
        case .ratingIndex: return "⭐️"
        case .keywordsTerm: return "🔑"
        case .descriptionTerm: return "🧾"
        }
    }
}
