//
//  FetchMusicRepositoryInterface.swift
//  Domain
//
//  Created by Quarang on 5/8/25.
//

import Foundation
import RxSwift

// MARK: - 아이튠즈 데이터 요청 레포지토리
public protocol FetchITunesRepositoryInterface {
    func fetchITunesData(term: String, media: MediaType, attributes: String) -> Single<[ITunes]>
}
