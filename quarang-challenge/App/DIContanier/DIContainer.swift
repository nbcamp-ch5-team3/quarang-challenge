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
    
    func makeITunesViewController(_ type: ViewType) -> UIViewController {
        let repository = FetchITunesRepository()
        let useCase = FetchITunesUseCase(repository: repository)
        let viewModel = ITunesViewModel(fetchITunesUscase: useCase)
        return ITunesViewController(viewModel: viewModel)
    }
    
    var makeTabBarController: UITabBarController {
        let tabbar = TabBarController()
        
        let musicVC = makeITunesViewController(.music)
        musicVC.tabBarItem = UITabBarItem(title: "Music", image: UIImage(systemName: "music.note"), tag: 1)
        musicVC.navigationController?.navigationBar.topItem?.title = "Music"
        
        tabbar.viewControllers = [musicVC]
        return tabbar
    }
}
