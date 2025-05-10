//
//  FetchLookUpRepository.swift
//  Data
//
//  Created by Quarang on 5/9/25.
//

import RxSwift
import Domain

// MARK: - 상세데이터 요청 레포지토리 구현체
public final class FetchLookUpRepository: FetchLookUpRepositoryInterface {
    
    private let manager = ITunesAPIManager.shared
    public init() { }
    
    public func fetchLookUP(id: Int,_ type: MediaType) -> Single<[ITunesDetail]> {
        manager.fetchITunesDetailData(id: id, media: type)
    }
}
