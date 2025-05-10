//
//  FetchLookUpRepository.swift
//  Data
//
//  Created by Quarang on 5/9/25.
//

import RxSwift
import Domain

// MARK: - 상세데이터 요청 레포지토리
public final class FetchLookUpRepository: FetchLookUpRepositoryInterface {
    
    public init() { }
    
    public func fetchLookUP(id: String,_ type: MediaType) -> Single<[ITunes]> {
        return Single.create { single in
            return Disposables.create()
        }
    }
}
