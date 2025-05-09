//
//  FetchMusicUseCaseInterface.swift
//  Domain
//
//  Created by Quarang on 5/8/25.
//

import Foundation
import RxSwift

// MARK: - 아이튠즈 데이터 요청 유즈케이스
protocol FetchITunesUseCaseInterface {
    func excute(_ type: ViewType) -> Single<[ITunes]>
}
