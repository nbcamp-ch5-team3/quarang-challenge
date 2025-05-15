//
//  FetchLookUpUseCaseInterface.swift
//  Domain
//
//  Created by Quarang on 5/9/25.
//

import Foundation
import RxSwift

// MARK: - 상세 데이터 요청 유즈케이스
protocol FetchLookUpUseCaseInterface {
    func execute(id: Int,_ type: MediaType) -> Single<[ITunesDetail]>
}
