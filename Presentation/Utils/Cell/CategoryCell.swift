//
//  CategoryCell.swift
//  Presentation
//
//  Created by Quarang on 5/14/25.
//

import UIKit
import Domain

class CategoryCell: UICollectionViewCell {
    
    static let identifier = "CategoryCell"
    
    private let label = PaddedLabel(vertical: 8, horizontal: 16).then {
        $0.backgroundColor = .systemGray5
        $0.textColor = .label
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.textAlignment = .center
        $0.font = .boldSystemFont(ofSize: 14)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    /// 뷰 추가 및 설정
    private func configureViews() {
        contentView.addSubview(label)
    }
    /// 오토레이아웃 설정
    private func configureLayout() {
        label.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    /// 셀 외부에서 데이터 업데이트
    func configure(attributes: ITunesAttributes, selected: Bool) {
        label.text = "\(attributes.image) \(attributes.label)"
        label.backgroundColor = selected ? .systemBlue : .systemGray5
        label.textColor = selected ? .white : .label
    }
}
