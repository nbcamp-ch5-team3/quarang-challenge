//
//  ViewModelType.swift
//  Presentation
//
//  Created by Quarang on 5/13/25.
//

import Foundation
internal import RxSwift

// MARK: - 뷰모델 프로토콜 정의
protocol ViewModelType {
    associatedtype Action
    associatedtype State
    
    var disposeBag: DisposeBag { get }          // DisposeBag
    var action: AnyObserver<Action> { get }     // Action을 주입받을 통로
    var state: State { get }                    // View 쪽에 전달되는 상태 스트림
}
