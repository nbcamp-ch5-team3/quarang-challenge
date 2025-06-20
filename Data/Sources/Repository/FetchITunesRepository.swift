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
    
    private let manager = ITunesAPIManager.shared
    public init() { }
    
    public func fetchITunesData(term: String, media: MediaType, attributes: String) -> Single<[ITunes]> {
        manager.fetchITunesData(term: term, media: media, attributes: attributes)
    }
}
