//
//  DetailView.swift
//  Presentation
//
//  Created by Quarang on 5/10/25.
//

import UIKit
import Domain
import AVFoundation

internal import SnapKit

// MARK: - 상세페이지 뷰
final class DetailView: UIView {
    
    /// 음악 플레이어
    private var player: AVPlayer?
    
    // MARK: 동적 이미지를 위한 제약 및
    private var artworkHeightConstraint: Constraint?        // 썸네일 이미지 제약
    private var originalArtworkHeight: CGFloat = 0          // 썸네일 높이
    
    // MARK: 컴포넌트
    
    /// 최상단 셀뷰
    private let cellView = ITunesCellView()
    
    /// 비디오 플레이어
    private let videoPlayerView = VideoPlaybackView()

    /// 스크롤 뷰
    private let scrollView = UIScrollView()
    
    /// 컨텐츠 스택 뷰
    private let contentStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 12
    }
    
    /// 뒤로가기 버튼
    private let dismissButton = UIButton(type: .system).then {
        let image = UIImage(systemName: "xmark.circle.fill")?.withRenderingMode(.alwaysTemplate)
        $0.setImage(image, for: .normal)
        $0.tintColor = .white
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.25
        $0.layer.shadowOffset = CGSize(width: 0, height: 2)
        $0.layer.shadowRadius = 4
        $0.layer.masksToBounds = false
    }
    
    /// 썸네일 이미지
    private let artworkImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    /// 타이틀
    private let titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 20)
        $0.numberOfLines = 2
    }
    
    /// 연령제한
    private let contentAdvisoryImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    /// 타이틀 + 연령제한
    private let titleStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 8
        $0.distribution = .equalSpacing
    }
    
    /// 서브 타이틀
    private let subtitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textColor = .secondaryLabel
    }
    
    /// 가격
    private let priceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .systemGray
    }
    
    /// 설명
    private let descriptionLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.textColor = .label
        $0.numberOfLines = 0
    }
    
    /// 장르
    private let genreLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .systemGray
    }
    
    /// 출시 일자
    private let releaseDateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .systemGray
    }
    
    /// 플레이 타임
    private let timeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13)
        $0.textColor = .systemBlue
    }
    
    /// 사이트 링크 버튼
    private let externalLinkButton = UIButton(type: .system).then {
        var config = UIButton.Configuration.plain()
        config.title = "사이트에서 보기"
        config.image = UIImage(systemName: "link")
        config.imagePadding = 8
        config.baseForegroundColor = .systemBackground
        config.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20)
        $0.configuration = config
        $0.backgroundColor = UIColor.label
        $0.layer.cornerRadius = 16
        $0.titleLabel?.font = .boldSystemFont(ofSize: 16)
    }
    
    /// 재생 버튼
    private let playButton = UIButton(type: .system).then {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "play.fill")
        config.imagePadding = 8
        config.imagePlacement = .leading
        config.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 20, bottom: 16, trailing: 20)
        $0.configuration = config
        $0.layer.cornerRadius = 16
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.systemGray3.cgColor
        $0.titleLabel?.font = .boldSystemFont(ofSize: 16)
    }
    
    /// 레이아웃
    private let layout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.itemSize = CGSize(width: 180, height: 360)
        $0.minimumLineSpacing = 16
        $0.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    /// 스크린샷 컬렉션 뷰
    private lazy var screenshotCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout).then {
        $0.showsHorizontalScrollIndicator = false
        $0.backgroundColor = .clear
        $0.isPrefetchingEnabled = true
        $0.decelerationRate = .fast
        $0.register(ScreenshotCell.self, forCellWithReuseIdentifier: "ScreenshotCell")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAddView()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.originalArtworkHeight = self.artworkImageView.bounds.width
    }
    
    /// 서브 뷰 추가
    private func configureAddView() {
        backgroundColor = .systemBackground
        
        [artworkImageView, scrollView, dismissButton, playButton]
            .forEach { addSubview($0) }
        
        [titleLabel, contentAdvisoryImageView]
            .forEach { titleStackView.addArrangedSubview($0) }
        
        scrollView.addSubview(contentStackView)
        
        [cellView, titleStackView, subtitleLabel, priceLabel, descriptionLabel,
         genreLabel, releaseDateLabel,
         timeLabel, videoPlayerView, screenshotCollectionView, externalLinkButton, playButton].forEach {
            contentStackView.addArrangedSubview($0)
        }
    }
    
    /// 오토레이아웃
    private func configureLayout() {
        
        artworkImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.width.equalTo(safeAreaLayoutGuide)
            artworkHeightConstraint = $0.height.equalTo(artworkImageView.snp.width).constraint
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(artworkImageView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
        
        contentStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
            $0.width.equalTo(scrollView.snp.width).offset(-32)
        }
        
        cellView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(72)
        }
        
        dismissButton.snp.makeConstraints {
            $0.top.trailing.equalTo(safeAreaLayoutGuide).inset(16)
        }
        
        videoPlayerView.snp.makeConstraints {
            $0.height.equalTo(200)
        }
        
        screenshotCollectionView.snp.makeConstraints {
            $0.height.equalTo(360)
        }
    }
    
    /// 디테일 뷰 설정
    func configure(with detail: ITunesDetail) {
        cellView.configure(with: detail.toITunes)
        artworkImageView.load(url: detail.artworkURL)
        titleLabel.text = detail.title
        subtitleLabel.text = detail.subtitle
        descriptionLabel.text = detail.description
        genreLabel.text = "장르: " + detail.genre
        priceLabel.text = detail.priceText
        releaseDateLabel.text = "출시일: " + detail.releaseDate.toString()

        updateContentAdvisoryImageView(advisory: detail.contentAdvisory)
        updateTimeLabel(milliseconds: detail.trackTimeMillis)
        updatePreviewPlayer(using: detail.previewURL)
        
        screenshotCollectionView.isHidden = detail.screenshotURLs.isEmpty
        externalLinkButton.isHidden = detail.detailURL == nil
    }
    
    /// 접근
    var getDismissButton: UIButton {
        dismissButton
    }
    
    var getScreenshotCollectionView: UICollectionView {
        screenshotCollectionView
    }
    
    var getPlayer: AVPlayer? {
        player
    }
    
    var getplayerButton: UIButton {
        playButton
    }
    
    var getExternalLinkButton: UIButton {
        externalLinkButton
    }
    
    var getScrollView: UIScrollView {
        scrollView
    }
    
    var getArtworkImageView: UIImageView {
        artworkImageView
    }
}

extension DetailView {

    /// 연령 제한 이미지 설정
    private func updateContentAdvisoryImageView(advisory: String?) {
        contentAdvisoryImageView.tintColor = advisory == "19.circle" ? .systemRed : .systemGreen
        contentAdvisoryImageView.image = UIImage(systemName: advisory ?? "")?
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 16, weight: .regular))
    }

    /// 출시일 설정
    private func updateTimeLabel(milliseconds: Int?) {
        if let milliseconds {
            timeLabel.text = "플레이 타임: \(milliseconds / 60000)분"
        } else {
            timeLabel.isHidden = true
        }
    }
    
    /// 프리뷰에 따른 재생 버튼 설정
    private func updatePreviewPlayer(using url: URL?) {
        if let url {
            switch url.pathExtension {
            case "m4a":
                player = AVPlayer(url: url)
                videoPlayerView.isHidden = true
                playButton.setTitle("미리 듣기", for: .normal)
            case "m4v":
                videoPlayerView.configure(with: url)
                player = videoPlayerView.getPlayer()
                playButton.setTitle("미리 보기", for: .normal)
            default:
                videoPlayerView.isHidden = true
                playButton.isHidden = true
            }
        } else {
            videoPlayerView.isHidden = true
            playButton.isHidden = true
        }
    }
    
    // 스크롤에 따른 썸네일 이미지 크기 설정
    func updateArtworkImageHeight(by offsetY: CGFloat) {
        guard originalArtworkHeight > 0 else { return }
        let progress = min(max(offsetY/200, 0), 1)
        let adjustedHeight = originalArtworkHeight * -progress
        artworkHeightConstraint?.update(offset: adjustedHeight)
        artworkImageView.alpha = 1 - progress
    }
}

