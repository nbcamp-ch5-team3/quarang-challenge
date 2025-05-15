//
//  ITunesCollectionViewCell.swift
//  Presentation
//
//  Created by Quarang on 5/9/25.
//

import UIKit
import Domain

final class ITunesThumbnailCell: UICollectionViewCell {
    
    static let identifier = "ITunesThumbnailCell"

    // 그라데이션 뷰 및 셀 정의
    private let gradientView = UIView()
    private let itunesCellView = ITunesCellView()
    
    /// 그라데이션 설정
    private lazy var gradientLayer = CAGradientLayer().then {
        $0.frame = self.contentView.bounds
        $0.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.5).cgColor,
            UIColor.black.cgColor,
        ]
        $0.locations = [0.3, 0.6]
    }
    
    /// 썸네일
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        $0.isUserInteractionEnabled = true
    }

    /// 타이틀 - 작품명
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 18, weight: .semibold)
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureLayout()
        itunesCellView.configureColor()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 셀 재사용
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        genreLabel.text = nil
        priceLabel.text = nil
    }
    
    /// 뷰 추가 및 설정
    private func configureViews() {
        [titleLabel, subtitleLabel, imageView, genreLabel, priceLabel]
            .forEach { contentView.addSubview($0) }
        [gradientView, itunesCellView]
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
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(8)
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(imageView.snp.width).dividedBy(1.5)
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
        
        itunesCellView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        itunesCellView.getProfileView.snp.makeConstraints {
            $0.bottom.leading.equalToSuperview().inset(16)
        }
    }

    /// 셀 외부에서 데이터 업데이트
    func configure(with item: ITunes) {
        imageView.load(url: item.imageURL)
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle + " · " + item.releaseDate.toString(format: "yyyy")
        genreLabel.text = item.genre
        priceLabel.text = item.priceText
        
        itunesCellView.configure(with: item)
    }
    
    /// 접근
    var getImageView: UIImageView {
        imageView
    }
    
    /// 접근
    var getItunesCellView: ITunesCellView {
        itunesCellView
    }
}

    
