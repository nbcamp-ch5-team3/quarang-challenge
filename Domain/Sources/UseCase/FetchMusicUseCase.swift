//
//  FetchMusicUseCase.swift
//  Domain
//
//  Created by Quarang on 5/8/25.
//

import Foundation

public final class FetchMusicUseCase : FetchMusicUseCaseInterface {
    
    let repository: FetchMusicRepositoryInterface
    
    public init (repository: FetchMusicRepositoryInterface) {
        self.repository = repository
    }
    
}
