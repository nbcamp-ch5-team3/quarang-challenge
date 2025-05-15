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

// MARK: 아이튠즈를 위한 repo -> use case -> VM -> VC 순서로 의존성 주입 컨테이너
final class DIContainer {
    
    /// 탭바 아이템 설정 및 네비게이션 컨트롤러 설정 및 변환
    private func makeNavigationController(_ vc: UIViewController, type: ViewType) -> UINavigationController {
        vc.tabBarItem = UITabBarItem(title: type.text, image: UIImage(systemName: type.image), tag: type.tag)
        vc.navigationItem.title = type.text
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.prefersLargeTitles = true
        vc.navigationItem.largeTitleDisplayMode = .always
        return nav
    }
    
    /// 아이튠즈 VC 생성 (타입에 따라 music, movie, app, podcast로 분류)
    func makeITunesViewController(_ type: ViewType) -> UIViewController {
        let repository = FetchITunesRepository()
        let useCase = FetchITunesUseCase(repository: repository)
        let viewModel = ITunesViewModel(fetchITunesUscase: useCase)
        let vc = ITunesViewController(viewModel: viewModel,type: type, DIContainer: self)
        return makeNavigationController(vc, type: type)
    }
    
    /// 검색 VC 생성
    func makeSearchViewController() -> UIViewController {
        let type = ViewType.search(media: .music, entity: "all")
        let repository = FetchITunesRepository()
        let useCase = FetchITunesUseCase(repository: repository)
        let viewModel = SearchViewModel(fetchITunesUscase: useCase)
        let vc = SearchViewController(viewModel: viewModel, type: type)
        return makeNavigationController(vc, type: type)
    }
    
    /// 의존성 주입이 완료된 뷰들을 탭바 아이템으로 지정
    var makeTabBarController: UITabBarController {
        let tabbar = UITabBarController()
        let musicVC = makeITunesViewController(.music(entity: ""))
        let movieVC = makeITunesViewController(.movie(entity: ""))
        let appVC = makeITunesViewController(.app(entity: ""))
        let podcastVC = makeITunesViewController(.podcast(entity: ""))
        let searchVC = makeSearchViewController()
        
        tabbar.viewControllers = [musicVC, movieVC, appVC, podcastVC, searchVC]
        return tabbar
    }
}

// MARK: DetailView push를 위한 의존성 주입
extension DIContainer: DetailDIContainerInterface {
    
    /// 아이튠즈 VC에 DIContainer를 주입해 의존성을 주입한 상세페이지 VC를 push할 수 있도록 구현
    func makeDetailViewController(id: Int, _ type: MediaType) -> UIViewController {
        let repository = FetchLookUpRepository()
        let useCase = FetchLookUpUseCase(repository: repository)
        let viewModel = DetailViewViewModel(fetchLookUpuseCase: useCase, id: id, type: type)
        return DetailViewViewController(viewModel: viewModel)
    }
}
