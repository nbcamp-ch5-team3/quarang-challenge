//
//  FetchMusicUseCase.swift
//  Domain
//
//  Created by Quarang on 5/8/25.
//

import Foundation

public final class FetchITunesUseCase : FetchITunesUseCaseInterface {
    
    let repository: FetchITunesRepositoryInterface
    
    public init (repository: FetchITunesRepositoryInterface) {
        self.repository = repository
    }
    
}
