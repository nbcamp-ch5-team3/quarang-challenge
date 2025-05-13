//
//  ITunesCollectionViewCell.swift
//  Presentation
//
//  Created by Quarang on 5/9/25.
//

import UIKit
import Domain
internal import SnapKit
internal import Then

final class ITunesThumbnailCell: UICollectionViewCell {
    
    static let identifier = "ITunesThumbnailCell"

    // 블러처리된 뷰 및 그라데이션 뷰
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
    private let gradientView = UIView()
    
    /// 그라데이션 설정
    private lazy var gradientLayer = CAGradientLayer().then {
        $0.frame = self.contentView.bounds
        $0.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.5).cgColor
        ]
        $0.locations = [0.5, 1.0]
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
    
    /// 썸네일
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    /// 작은 이미지
    private let profileView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }

    /// 타이틀 - 작품명
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .label
        $0.numberOfLines = 1
        $0.clipsToBounds = true
    }

    /// 서브 타이틀 - 아티스트 + 연도
    private let subtitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .secondaryLabel
        $0.numberOfLines = 1
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

    /// 장르
    private let genreLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .systemBlue
    }

    /// 가격
    private let priceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .systemGray
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureLayout()
        configureImageLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    /// 뷰 추가 및 설정
    private func configureViews() {
        [titleLabel, subtitleLabel, imageView, genreLabel, priceLabel]
            .forEach { contentView.addSubview($0) }
        [blurView, gradientView, imageTitleStackView, profileView, imageButtonStackView]
            .forEach { imageView.addSubview($0) }
        gradientView.layer.addSublayer(gradientLayer)
    }

    /// 오토레이아웃 설정
    private func configureLayout() {

        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
            $0.width.equalToSuperview()
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(4)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(imageView.snp.width).dividedBy(1.5)
        }
        
        blurView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        gradientView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        genreLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(4)
            $0.leading.equalToSuperview()
        }

        priceLabel.snp.makeConstraints {
            $0.top.equalTo(genreLabel.snp.bottom)
            $0.leading.equalToSuperview()
        }
    }
    
    /// 이미지 내부 오토레이아웃 설정
    private func configureImageLayout() {
        profileView.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(16)
            $0.size.equalTo(CGSize(width: 64, height: 64))
        }
        
        imageTitleStackView.snp.makeConstraints {
            $0.leading.equalTo(profileView.snp.trailing).offset(8)
            $0.centerY.equalTo(profileView).offset(8)
            $0.width.equalTo(128)
        }

        imageButtonStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalTo(profileView).offset(8)
        }
    }

    /// 셀 외부에서 데이터 업데이트
    func configure(with item: ITunes) {
        imageView.load(url: item.imageURL)
        profileView.load(url: item.imageURL)
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle + " · " + item.releaseDate.toString(format: "yyyy")
        imageTitleLabel.text = item.title
        imageSubtitleLabel.text = item.subtitle + " · " + item.releaseDate.toString(format: "yyyy")
        genreLabel.text = item.genre
        priceLabel.text = item.priceText
    }
    
    /// 접근
    var getImageView: UIImageView {
        imageView
    }
}
