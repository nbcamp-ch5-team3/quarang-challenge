//
//  ITunesCell.swift
//  Presentation
//
//  Created by Quarang on 5/13/25.
//

import UIKit
import Domain
internal import SnapKit
internal import Then

class ITunesCell: UICollectionViewCell {
    
    static let identifier = "ITunesCell"
    
    private let itunesCellView = ITunesCellView()
    
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
        itunesCellView.getProfileView.image = nil
        itunesCellView.getImageTitleLabel.text = nil
        itunesCellView.getImageSubtitleLabel.text = nil
    }
    
    /// 뷰 추가 및 설정
    private func configureViews() {
        contentView.addSubview(itunesCellView)
    }
    /// 오토레이아웃 설정
    private func configureLayout() {
        itunesCellView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    /// 셀 외부에서 데이터 업데이트
    func configure(with item: ITunes) {
        itunesCellView.configure(with: item)
    }
}
