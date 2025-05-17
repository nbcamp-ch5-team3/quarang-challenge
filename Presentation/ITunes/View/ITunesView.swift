//
//  MainView.swift
//  Presentation
//
//  Created by Quarang on 5/9/25.
//

import Foundation
import UIKit

// MARK: - 아이튠즈 뷰
final class ITunesView : UIView {
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout)
    
    /// 레이아웃 설정
    private var createLayout: UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            self.itunesSection(to: sectionIndex)
        }
    }
    /// 섹션 헤더
    private var sectionHeader: NSCollectionLayoutBoundarySupplementaryItem {
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .absolute(64)
        )
        let header = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
        header.extendsBoundary = true
        return header
    }
    
    /// 레이아웃 그룹
    private func itunesLayoutGroup(to index: Int) -> NSCollectionLayoutGroup {
        // 셀 크기를 콘텐츠 길이에 맞게 동적 조정
        switch index {
        case 0:
            // 카테고리 컬렉션뷰
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .estimated(200),
                heightDimension: .estimated(44)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .estimated(200),
                heightDimension: .estimated(44)
            )
            return NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        case 1:
            // 썸네일 컬렉션뷰 (봄)
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .fractionalHeight(0.4)
            )
            return NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        default:
            // 나머지 컬렉션뷰(여름, 가을, 겨울)
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.35)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .fractionalHeight(0.3)
            )
            return NSCollectionLayoutGroup.vertical(layoutSize: groupSize, repeatingSubitem: item, count: 3)
        }
    }
    
    /// 섹션
    private func itunesSection(to index: Int) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: itunesLayoutGroup(to: index))
        section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        section.interGroupSpacing = 8
        section.orthogonalScrollingBehavior = index == 0 ? .continuous : .groupPagingCentered
        section.boundarySupplementaryItems = index == 0 ? [] : [sectionHeader]
        return section
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
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // 접근
    var getCollectionView: UICollectionView {
        collectionView
    }
}
