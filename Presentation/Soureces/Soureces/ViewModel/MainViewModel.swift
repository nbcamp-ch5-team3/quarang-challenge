//
//  MainViewModel.swift
//  quarang-challenge
//
//  Created by Quarang on 5/8/25.
//

import Foundation

final class MainViewModel {
    
    let fetchMusicUscase: FetchMusicUseCase
    
    init (fetchMusicUscase: FetchMusicUseCase) {
        self.fetchMusicUscase = fetchMusicUscase
    }
    
}
