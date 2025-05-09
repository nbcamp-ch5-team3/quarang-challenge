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
        let vc = ITunesViewController(viewModel: viewModel, type: type)
        vc.tabBarItem = UITabBarItem(title: type.text, image: UIImage(systemName: type.image), tag: type.tag)
        vc.navigationController?.navigationBar.topItem?.title = type.text
        return vc
    }
    
    func makeSearchViewController() -> UIViewController {
        let type = ViewType.search(media: "", entity: "")
        let repository = FetchITunesRepository()
        let useCase = FetchITunesUseCase(repository: repository)
        let viewModel = SearchViewModel(fetchITunesUscase: useCase)
        let vc = SearchViewController(viewModel: viewModel)
        vc.tabBarItem = UITabBarItem(title: type.text, image: UIImage(systemName: type.image), tag: type.tag)
        vc.navigationController?.navigationBar.topItem?.title = type.text
        return vc
    }
    
    var makeTabBarController: UITabBarController {
        let tabbar = TabBarController()
        let musicVC = makeITunesViewController(.music(entity: ""))
        let movieVC = makeITunesViewController(.movie(entity: ""))
        let appVC = makeITunesViewController(.app(entity: ""))
        let podcastVC = makeITunesViewController(.podcast(entity: ""))
        let searchVC = makeSearchViewController()
        
        tabbar.viewControllers = [musicVC, movieVC, appVC, podcastVC, searchVC]
        return tabbar
    }
}
