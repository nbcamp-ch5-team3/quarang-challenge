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
    
    func makeFetchMainViewModel() -> MainViewModel {
        let repository = FetchMusicRepository()
        let useCase = FetchMusicUseCase(repository: repository)
        return MainViewModel(fetchMusicUscase: useCase)
    }
    
    var mainViewController: UIViewController {
        MainViewController(viewModel: makeFetchMainViewModel())
    }
}
