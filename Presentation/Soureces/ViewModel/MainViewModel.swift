//
//  MainViewModel.swift
//  quarang-challenge
//
//  Created by Quarang on 5/8/25.
//

import Foundation
import Domain

public final class MainViewModel {
    
    let fetchMusicUscase: FetchMusicUseCase
    
    public init (fetchMusicUscase: FetchMusicUseCase) {
        self.fetchMusicUscase = fetchMusicUscase
    }
    
}
