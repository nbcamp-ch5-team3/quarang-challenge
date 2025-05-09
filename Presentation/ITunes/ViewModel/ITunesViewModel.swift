//
//  MainViewModel.swift
//  quarang-challenge
//
//  Created by Quarang on 5/8/25.
//

import Foundation
import Domain

// MARK: - 아이튠즈 뷰 모델
public final class ITunesViewModel {
    
    let fetchITunesUscase: FetchITunesUseCase
    
    public init (fetchITunesUscase: FetchITunesUseCase) {
        self.fetchITunesUscase = fetchITunesUscase
    }
    
}
