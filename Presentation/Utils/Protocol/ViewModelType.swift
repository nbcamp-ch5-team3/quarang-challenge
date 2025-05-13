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
    
    var disposeBag: DisposeBag { get }
    var action: Action { get }
}
