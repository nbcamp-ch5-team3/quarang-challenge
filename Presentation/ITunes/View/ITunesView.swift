//
//  MainView.swift
//  Presentation
//
//  Created by Quarang on 5/9/25.
//

import Foundation
import UIKit
internal import SnapKit
internal import Then

// MARK: - 아이튠즈 뷰
final class ITunesView : UIView {
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: ITunesView.createLayout())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAddView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAddView() {
        addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    
    private static func createLayout() -> UICollectionViewLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(1.0)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(
                widthDimension: .estimated(200),
                heightDimension: .absolute(280)
            )
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
            section.interGroupSpacing = 8
            section.orthogonalScrollingBehavior = .groupPagingCentered

            return section
        }
    }
    
    var getCollectionView: UICollectionView {
        collectionView
    }
}
