//
//  DetailViewViewModel.swift
//  Presentation
//
//  Created by Quarang on 5/10/25.
//

import UIKit
import Domain
internal import RxSwift

// MARK: - 상세페이지 뷰 모델
public final class DetailViewViewModel: BaseViewModel, ViewModelType {
    
    enum Action {
        case viewDidLoad
    }
    
    struct State {
        private(set) var actionSubject = PublishSubject<Action>()
    }
    
    var state = State()
    var disposeBag = DisposeBag()
    var action: AnyObserver<Action> {
        state.actionSubject.asObserver()
    }

    private let fetchLookUpuseCase: FetchLookUpUseCase
    private let id: Int
    private let type: MediaType
    
    public init (fetchLookUpuseCase: FetchLookUpUseCase, id: Int, type: MediaType) {
        self.id = id
        self.type = type
        self.fetchLookUpuseCase = fetchLookUpuseCase
        super.init()
    }
    
    /// 바인딩
    private func bind() {
        state.actionSubject
            .subscribe(with: self) { owner, action in
                switch action {
                case .viewDidLoad: owner.fetchData()
                }
            }
            .disposed(by: disposeBag)
    }
    
    /// 데이터 요청
    private func fetchData() {
        fetchLookUpuseCase.execute(id: id, type)
            .subscribe(with: self, onSuccess: { owner, details in
                
            }) { owner, error in
                owner.errorHandler(error)
            }
            .disposed(by: disposeBag)
    }
}
