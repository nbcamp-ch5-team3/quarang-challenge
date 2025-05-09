//
//  FetchLooUpRepositoryInterface.swift
//  Domain
//
//  Created by Quarang on 5/9/25.
//

import Foundation
import RxSwift

// MARK: - 상세 데이터 요청 레포지토리
public protocol FetchLookUpRepositoryInterface {
    func fetchLookUP(id: String,_ type: MediaType) -> Single<[ITunes]>
}
