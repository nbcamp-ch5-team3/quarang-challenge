//
//  DIContainer.swift
//  quarang-challenge
//
//  Created by Quarang on 5/8/25.
//

import Foundation
import Data
import Domain
import Presentation

final class DIContainer {
    
    func makeFetchMainViewModel() -> MainViewModel {
        let repository = FetchMusicRepository()
        let useCase = FetchMusicUseCase(repository: repository)
        return MainViewModel(fetchMusicUscase: useCase)
    }

}
