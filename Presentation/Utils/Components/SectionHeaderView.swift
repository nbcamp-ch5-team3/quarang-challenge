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

    private let titleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textColor = .label
    }
    
    private let subTitleLabel = UILabel().then {
        $0.font = UIFont.boldSystemFont(ofSize: 18)
        $0.textColor = .secondaryLabel
    }
    
    private lazy var titleStackView = UIStackView(arrangedSubviews: [titleLabel, subTitleLabel]).then {
        $0.axis = .vertical
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureAddSubViews()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 서브 뷰 추가
    private func configureAddSubViews() {
        addSubview(titleStackView)
    }
    
    /// 레이아웃 설정
    private func configureLayout() {
        titleStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    /// 외부에서 헤더 데이터 설정
    func configure(title: String, subTitle: String) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
    }
}
