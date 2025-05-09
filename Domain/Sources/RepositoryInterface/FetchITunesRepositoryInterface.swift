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
    func fetchMusic(entity: String) -> Single<[ITunes]>
    func fetchMovie(entity: String) -> Single<[ITunes]>
    func fetchApp(entity: String) -> Single<[ITunes]>
    func fetchPodcast(entity: String) -> Single<[ITunes]>
    func searchITunes(media: String, entity: String) -> Single<[ITunes]>
}
