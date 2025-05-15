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
    
    /// 레이아웃 설정
    private var createLayout: UICollectionViewLayout {
        UICollectionViewCompositionalLayout { _, _ in
            self.itunesSection
        }
    }
    
    /// 레이아웃 그룹
    private var itunesLayoutGroup: NSCollectionLayoutGroup {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(72)
        )
        return NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
    }
    
    /// 섹션
    private var itunesSection: NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: itunesLayoutGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        section.interGroupSpacing = 8
        return section
    }
    
    /// 컬렉샨 뷰
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout).then {
        $0.keyboardDismissMode = .onDrag
    }
    
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
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
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
