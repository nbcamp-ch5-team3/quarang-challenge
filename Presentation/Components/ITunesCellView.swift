//
//  ITunesCellView.swift
//  Presentation
//
//  Created by Quarang on 5/13/25.
//

import UIKit
import Domain
internal import SnapKit
internal import Then

class ITunesCellView: UIView {
    
    /// 작은 이미지
    private let profileView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }

    /// 이미지 내부 타이틀
    private let imageTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .systemBackground
        $0.numberOfLines = 1
        $0.clipsToBounds = true
    }

    /// 이미지 내부 서브 타이틀
    private let imageSubtitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .white
        $0.numberOfLines = 1
        $0.clipsToBounds = true
    }
    
    /// 이미지 내부 받기 버튼
    private let downLoadLabel = PaddedLabel(vertical: 8, horizontal: 24).then {
        $0.text = "받기"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }

    /// 이미지 내부 구입
    private let purchaseLabel = UILabel().then {
        $0.text = "앱 내 구입"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    /// 프로필 제목 + 작가 + 연도 스택
    private lazy var imageTitleStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.addArrangedSubview(imageTitleLabel)
        $0.addArrangedSubview(imageSubtitleLabel)
    }
    
    /// 받기 + 앱 내 구입 스택
    private lazy var imageButtonStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.addArrangedSubview(downLoadLabel)
        $0.addArrangedSubview(purchaseLabel)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 뷰 추가 및 설정
    private func configureViews() {
        [profileView, imageTitleStackView, profileView, imageButtonStackView]
            .forEach { addSubview($0) }
    }
    
    /// 이미지 내부 오토레이아웃 설정
    private func configureLayout() {
        
        profileView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(16)
            $0.size.equalTo(CGSize(width: 64, height: 64))
        }
        
        imageTitleStackView.snp.makeConstraints {
            $0.leading.equalTo(profileView.snp.trailing).offset(8)
            $0.centerY.equalTo(profileView)
            $0.width.equalTo(128)
        }

        imageButtonStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(profileView).offset(8)
        }
    }
    
    /// 셀 외부에서 데이터 업데이트
    func configure(with item: ITunes) {
        profileView.load(url: item.imageURL)
        imageTitleLabel.text = item.title
        imageSubtitleLabel.text = item.subtitle + " · " + item.releaseDate.toString(format: "yyyy")
    }
}
