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
    
    let fetchMusicUscase: FetchMusicUseCase
    
    public init (fetchMusicUscase: FetchMusicUseCase) {
        self.fetchMusicUscase = fetchMusicUscase
    }
    
}
