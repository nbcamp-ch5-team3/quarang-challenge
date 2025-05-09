//
//  FetchMusicUseCase.swift
//  Domain
//
//  Created by Quarang on 5/8/25.
//

import Foundation
import RxSwift

// MARK: - 아이튠즈 데이터 요청 유즈케이스 구현체
public final class FetchITunesUseCase : FetchITunesUseCaseInterface {
    
    let repository: FetchITunesRepositoryInterface
    
    public init (repository: FetchITunesRepositoryInterface) {
        self.repository = repository
    }
    
    func excute(_ type: ViewType) -> Single<[ITunes]> {
        switch type {
        case let .music(entity): return repository.fetchMusic(entity: entity)
        case let .movie(entity): return repository.fetchMovie(entity: entity)
        case let .app(entity): return repository.fetchApp(entity: entity)
        case let .podcast(entity): return repository.fetchPodcast(entity: entity)
        case let .search(media, entity): return repository.searchITunes(media: media, entity: entity)
        }
    }
}
