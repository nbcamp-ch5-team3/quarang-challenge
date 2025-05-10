//
//  FetchLookUpUseCase.swift
//  Domain
//
//  Created by Quarang on 5/9/25.
//

import Foundation
import RxSwift

// MARK: - 상세 데이터 요청 유즈케이스 구현체
public final class FetchLookUpUseCase: FetchLookUpUseCaseInterface {
    
    let repository: FetchLookUpRepositoryInterface
    
    public init (repository: FetchLookUpRepositoryInterface) {
        self.repository = repository
    }
    
    public func excute(id: Int,_ type: MediaType) -> Single<[ITunesDetail]> {
        repository.fetchLookUP(id: id, type)
    }
}
