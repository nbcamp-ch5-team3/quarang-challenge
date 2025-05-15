//
//  SearchViewModel.swift
//  Presentation
//
//  Created by Quarang on 5/9/25.
//

import Foundation
import Domain
internal import RxSwift

// MARK: - 검색 관련 뷰모델
public final class SearchViewModel: ViewModelType {
    
    enum Action {
        case search(text:String, aatributes: String)
    }
    
    struct State {
        private(set) var actionSubject = PublishSubject<Action>()
    }
    
    var state = State()
    var disposeBag = DisposeBag()
    let fetchITunesUscase: FetchITunesUseCase
    
    var action: AnyObserver<Action> {
        state.actionSubject.asObserver()
    }
    
    public init (fetchITunesUscase: FetchITunesUseCase) {
        self.fetchITunesUscase = fetchITunesUscase
    }
    
    private func bind() {
        state.actionSubject
            .subscribe(with: self) { owner, action in
                switch action {
                    case let .search(text, attributes):
                    owner.fetchData(text: text, attributes: attributes)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func fetchData(text: String, attributes: String) {
        
    }
}
