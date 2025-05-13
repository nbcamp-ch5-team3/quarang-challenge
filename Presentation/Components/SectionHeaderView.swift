//
//  SectionHeaderView.swift
//  Presentation
//
//  Created by Quarang on 5/13/25.
//

import UIKit

// MARK: - 아이튠즈 섹션 헤더 뷰
final class SectionHeaderView: UICollectionReusableView {
    
    static let identifier = "SectionHeaderView"

    let titleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textColor = .label
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(8)
            $0.top.equalToSuperview().offset(12)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
