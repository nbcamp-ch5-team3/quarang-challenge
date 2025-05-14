//
//  MainViewModel.swift
//  quarang-challenge
//
//  Created by Quarang on 5/8/25.
//

import Foundation
import Domain
internal import RxSwift
import RxRelay

// MARK: - 아이튠즈 뷰 모델
public final class ITunesViewModel: ViewModelType {
    
    enum Action {
        case viewDidLoad(type: ViewType)
    }
    
    struct State {
        fileprivate(set) var actionSubject = PublishSubject<Action>()
        
        fileprivate(set) var springItems = BehaviorRelay<[ITunes]>(value: [])
        fileprivate(set) var summerItems = BehaviorRelay<[ITunes]>(value: [])
        fileprivate(set) var autumnItems = BehaviorRelay<[ITunes]>(value: [])
        fileprivate(set) var winterItems = BehaviorRelay<[ITunes]>(value: [])
    }
    
    var disposeBag = DisposeBag()
    var state = State()
    
    
    private let fetchITunesUscase: FetchITunesUseCase
    
    var action: AnyObserver<Action> {
        state.actionSubject.asObserver()
    }
    
    public init(fetchITunesUscase: FetchITunesUseCase) {
        
        self.fetchITunesUscase = fetchITunesUscase
        bind()
    }
    
    private func bind() {
        state.actionSubject
            .subscribe(with: self) { owner, action in
                switch action {
                case let .viewDidLoad(type):
                    owner.request(type)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func request(_ type: ViewType) {
        let terms = ["봄", "여름", "가을", "겨울"]
        let relays = [state.springItems, state.summerItems, state.autumnItems, state.winterItems]
        
        let requests = terms.map {
            fetchITunesUscase.excute(term: $0, type)
                .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
                .asObservable()
        }

        Observable.zip(requests)
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { results in
                zip(relays, results).forEach { relay, items in
                    relay.accept(items)
                }
                print("🎉 모든 시즌 데이터 수신 완료")
            }, onError: { [weak self] error in
                self?.errorHandler(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func errorHandler(_ error: Error) {
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
    }
}
