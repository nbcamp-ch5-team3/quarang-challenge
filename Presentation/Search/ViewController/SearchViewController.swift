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
    
    private let type: ViewType
    private let viewModel: SearchViewModel
    private let searchView = SearchView()
    private var disposeBag = DisposeBag()
    
    public override func loadView() {
        view = searchView
    }
    
    public init(viewModel: SearchViewModel, type: ViewType) {
        self.viewModel = viewModel
        self.type = type
        super.init(nibName: nil, bundle: nil)
        bindViewModel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        print(type.entityEnum)
        searchView.configure(type.entityEnum)
        // Do any additional setup after loading the view.
    }
    
    /// 컬렉션 뷰 설정
    private func setRegister() {
//        searchView.getCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        searchView.getCollectionView.register(ITunesCell.self, forCellWithReuseIdentifier: ITunesCell.identifier)
    }
    
    /// 뷰 바인딩
    private func bindViewModel() {
        Observable.combineLatest(
            searchView.getSearchBar.rx.text.orEmpty,
            searchView.getSearchBar.rx.selectedScopeButtonIndex
        )
        .filter { !$0.0.isEmpty }
        .debounce(.milliseconds(500), scheduler: MainScheduler.asyncInstance)
        .distinctUntilChanged { $0 == $1 }
        .subscribe(with: self) { owner, input in
            let (text, selectedIndex) = input
            print("최종 검색: \(text), 선택된 인덱스: \(selectedIndex)")
        }
        .disposed(by: disposeBag)
    }
}
