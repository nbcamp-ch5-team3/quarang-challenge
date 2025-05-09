//
//  FetchMusicRepository.swift
//  Data
//
//  Created by Quarang on 5/8/25.
//


import Domain
import RxSwift

// MARK: - 아이튠즈 데이터 요청 레포지토리 구현체
public final class FetchITunesRepository: FetchITunesRepositoryInterface {
    
    public init() { }
    
    public func fetchMusic(entity: String) -> Single<[ITunes]> {
        return Single.create { single in
            return Disposables.create()
        }
    }
    
    public func fetchMovie(entity: String) -> Single<[ITunes]> {
        return Single.create { single in
            return Disposables.create()
        }
    }
    
    public func fetchApp(entity: String) -> Single<[ITunes]> {
        return Single.create { single in
            return Disposables.create()
        }
    }
    
    public func fetchPodcast(entity: String) -> Single<[ITunes]> {
        return Single.create { single in
            return Disposables.create()
        }
    }
    
    public func searchITunes(media: String, entity: String) -> Single<[ITunes]> {
        return Single.create { single in
            return Disposables.create()
        }
    }
}
