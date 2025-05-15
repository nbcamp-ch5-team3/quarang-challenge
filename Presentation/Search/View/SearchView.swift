//
//  SearchView.swift
//  Presentation
//
//  Created by Quarang on 5/9/25.
//

import Domain
import UIKit
internal import RxCocoa

// MARK: - 검색 뷰
final class SearchView: UIView {
    
    /// 레이아웃
    private let layout = UICollectionViewFlowLayout()
    
    /// 컬렉샨 뷰
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    /// 검색바
    private let searchBar = UISearchBar().then {
        $0.showsScopeBar = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAddView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 컬렉션 뷰 추가 및 레이아웃 설정
    private func configureAddView() {
        [searchBar, collectionView]
            .forEach { addSubview($0) }
        
        searchBar.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.horizontalEdges.bottom.equalToSuperview()
        }
    }
    
    /// 세그먼트 컨트롤 설정
    func configure(_ itunes: [ITunesAttributes]) {
        searchBar.scopeButtonTitles = ViewType.allCases.filter { $0.tag < 5 }.map { $0.type.text }
    }
    
    // 접근
    var getCollectionView: UICollectionView {
        collectionView
    }
    
    var getSearchBar: UISearchBar {
        searchBar
    }
}
