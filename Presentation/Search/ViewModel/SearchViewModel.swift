//
//  SearchViewModel.swift
//  Presentation
//
//  Created by Quarang on 5/9/25.
//

import Foundation
import Domain

// MARK: - 검색 관련 뷰모델
public final class SearchViewModel {
    
    let fetchITunesUscase: FetchITunesUseCase
    
    public init (fetchITunesUscase: FetchITunesUseCase) {
        self.fetchITunesUscase = fetchITunesUscase
    }
}
