//
//  DetailViewViewModel.swift
//  Presentation
//
//  Created by Quarang on 5/10/25.
//

import UIKit
import Domain

// MARK: - 상세페이지 뷰 모델
public final class DetailViewViewModel {

    private let fetchLookUpuseCase: FetchLookUpUseCase
    private let id: Int
    private let type: MediaType
    
    public init (fetchLookUpuseCase: FetchLookUpUseCase, id: Int, type: MediaType) {
        self.id = id
        self.type = type
        self.fetchLookUpuseCase = fetchLookUpuseCase
    }
}
