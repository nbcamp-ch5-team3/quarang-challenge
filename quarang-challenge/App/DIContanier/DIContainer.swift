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
import UIKit

final class DIContainer {
    
    func makeFetchMainViewModel() -> ITunesViewModel {
        let repository = FetchMusicRepository()
        let useCase = FetchMusicUseCase(repository: repository)
        return ITunesViewModel(fetchMusicUscase: useCase)
    }
    
    var mainViewController: UIViewController {
        ITunesViewController(viewModel: makeFetchMainViewModel())
    }
}
