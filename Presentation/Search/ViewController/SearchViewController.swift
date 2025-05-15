//
//  SearchViewController.swift
//  Presentation
//
//  Created by Quarang on 5/9/25.
//

import UIKit
import Domain
internal import RxSwift

// MARK: 검색 뷰 컨트롤러
public final class SearchViewController: UIViewController {
    
    // MARK: - 프로퍼티
    private let type: ViewType
    private let viewModel: SearchViewModel
    private let DIContainer: DetailDIContainerInterface
    private let searchView = SearchView()
    private var disposeBag = DisposeBag()
    
    // MARK: - 초기설정
    public override func loadView() {
        view = searchView
    }
    
    public init(viewModel: SearchViewModel, type: ViewType, DIContainer: DetailDIContainerInterface) {
        self.viewModel = viewModel
        self.type = type
        self.DIContainer = DIContainer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        bindViewModel()
        setRegister()
        searchView.configure(type.attributesEnum)
    }
    
    /// 컬렉션 뷰 설정
    private func setRegister() {
        searchView.getCollectionView.register(ITunesCell.self, forCellWithReuseIdentifier: ITunesCell.identifier)
    }
    
    // MARK: - 바인딩
    
    /// 뷰 바인딩
    private func bindViewModel() {
        // 검색 이벤트 방출
        Observable.combineLatest(
            searchView.getSearchBar.rx.text.orEmpty,
            searchView.getSearchBar.rx.selectedScopeButtonIndex
        )
        .debounce(.milliseconds(500), scheduler: MainScheduler.asyncInstance)
        .distinctUntilChanged { $0 == $1 }
        .subscribe(with: self) { owner, input in
            let (text, selectedIndex) = input
            
            guard !text.isEmpty else {
                owner.viewModel.state.itunesItem.accept([])
                return
            }
            
            owner.viewModel.state.actionSubject.onNext(.search(text: text, type: ViewType.getViewType(index: selectedIndex)))
        }
        .disposed(by: disposeBag)
        
        // 로직 처리 후 데이터 바인딩
        viewModel.state.itunesItem
            .observe(on: MainScheduler.asyncInstance)
            .bind(to: searchView.getCollectionView.rx.items(
                cellIdentifier: ITunesCell.identifier,
                cellType: ITunesCell.self)
            ) { indexPath, item, cell in
                cell.configure(with: item)
                cell.getItunesCellView.delegate = self
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - 셀 이벤트 처리
extension SearchViewController: ITunesCellViewDelegate {
    func didTapDownLoadButton(id: Int) {
        let vc = DIContainer.makeDetailViewController(id: id, type.type)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
}
