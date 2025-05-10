//
//  MainViewModel.swift
//  quarang-challenge
//
//  Created by Quarang on 5/8/25.
//

import Foundation
import Domain
import RxSwift

// MARK: - 아이튠즈 뷰 모델
public final class ITunesViewModel {
    
    private(set) var type: ViewType
    var disposeBag = DisposeBag()
    let e = "song"
    private let fetchITunesUscase: FetchITunesUseCase
    
    public init(fetchITunesUscase: FetchITunesUseCase, type: ViewType) {
        self.type = type
        self.fetchITunesUscase = fetchITunesUscase
        updateEntity(to: e)
    }
    
    private func updateEntity(to newEntity: String) {
        switch type {
        case .music:
            type = .music(entity: newEntity)
        case .movie:
            type = .movie(entity: newEntity)
        case .app:
            type = .app(entity: newEntity)
        case .podcast:
            type = .podcast(entity: newEntity)
        case let .search(media, _):
            type = .search(media: media, entity: newEntity)
        }
    }
    
    func a() {
        fetchITunesUscase.excute(term: "봄", type)
            .subscribe(onSuccess: { items in
                // 정상 처리
                print("아이템 개수: \(items.count)")
            }, onFailure: { error in
                if let networkError = error as? NetWorkError {
                    switch networkError {
                    case .decodingError:
                        print("❗️디코딩에 실패했습니다. 형식을 확인하세요.")
                    case .statusCodeError(let code):
                        print("❗️서버 상태 코드 오류: \(code)")
                    case .dataParsingError:
                        print("❗️데이터가 존재하지 않습니다.")
                    default: break
                    }
                } else {
                    print("❗️알 수 없는 오류: \(error.localizedDescription)")
                }
            })
            .disposed(by: disposeBag)
    }
}
