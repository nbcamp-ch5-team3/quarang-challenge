//
//  SearchViewModel.swift
//  Presentation
//
//  Created by Quarang on 5/9/25.
//

import Foundation
import Domain
internal import RxSwift
import RxRelay

// MARK: - 검색 관련 뷰모델
public final class SearchViewModel: BaseViewModel, ViewModelType {
    
    enum Action {
        case search(text:String, type: ViewType)
    }
    
    struct State {
        private(set) var actionSubject = PublishSubject<Action>()
        
        private(set) var itunesItem = BehaviorRelay<[ITunes]>(value: [])
    }
    
    var state = State()
    var disposeBag = DisposeBag()
    let fetchITunesUscase: FetchITunesUseCase
    
    var action: AnyObserver<Action> {
        state.actionSubject.asObserver()
    }
    
    public init (fetchITunesUscase: FetchITunesUseCase) {
        self.fetchITunesUscase = fetchITunesUscase
        super.init()
        bind()
    }
    
    // 바인딩
    private func bind() {
        state.actionSubject
            .subscribe(with: self) { owner, action in
                switch action {
                    case let .search(text, type):
                    owner.fetchData(text: text, type: type)
                }
            }
            .disposed(by: disposeBag)
    }
    
    // 검색 결과 요청
    private func fetchData(text: String, type: ViewType) {
        fetchITunesUscase.execute(term: text, type)
            .subscribe(with: self, onSuccess: { owner, itunes in
                owner.state.itunesItem.accept(itunes)
            }, onFailure: { owner, error in
                owner.errorHandler(error)
            })
            .disposed(by: disposeBag)
    }
}
