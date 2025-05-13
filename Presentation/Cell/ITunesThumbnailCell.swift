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

    private let storeButton = AppStoreStyleButton()
    private let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
    private let gradientView = UIView()
    
    private lazy var gradientLayer = CAGradientLayer().then {
        $0.frame = self.contentView.bounds
        $0.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.5).cgColor
        ]
        $0.locations = [0.5, 1.0]
    }
    
    private lazy var imageTtileStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 4
        $0.addArrangedSubview(imageTitleLabel)
        $0.addArrangedSubview(imageSubtitleLabel)
    }
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }
    
    private let profileView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }

    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
        $0.textColor = .label
        $0.numberOfLines = 1
        $0.clipsToBounds = true
    }

    private let subtitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = .secondaryLabel
        $0.numberOfLines = 1
        $0.clipsToBounds = true
    }
    
    private let imageTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .systemBackground
        $0.numberOfLines = 1
        $0.clipsToBounds = true
    }

    private let imageSubtitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .white
        $0.numberOfLines = 1
        $0.clipsToBounds = true
    }

    private let genreLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .medium)
        $0.textColor = .systemBlue
    }

    private let priceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .systemGray
        $0.clipsToBounds = true
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
    
    private func configureViews() {
        [titleLabel, subtitleLabel, imageView, genreLabel, priceLabel]
            .forEach { contentView.addSubview($0) }
        [blurView, gradientView, imageTtileStackView, profileView, storeButton]
            .forEach { imageView.addSubview($0) }
        gradientView.layer.addSublayer(gradientLayer)
    }

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
    
    private func configureImageLayout() {
        profileView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalTo(storeButton).offset(8)
            $0.size.equalTo(CGSize(width: 64, height: 64))
        }
        
        imageTtileStackView.snp.makeConstraints {
            $0.leading.equalTo(profileView.snp.trailing).offset(8)
            $0.centerY.equalTo(storeButton).offset(8)
            $0.width.equalTo(128)
        }

        storeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(8)
            $0.bottom.equalToSuperview().inset(32)
            $0.height.equalTo(48)
        }
    }

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
    
    var getImageView: UIImageView {
        imageView
    }
}

// MARK: - UIImageView URL load helper (임시)
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}



// MARK: - App Store Style Button
final class AppStoreStyleButton: UIView {
    private let titleLabel = PaddedLabel(vertical: 8, horizontal: 24).then {
        $0.text = "받기"
        $0.font = .systemFont(ofSize: 16, weight: .bold)
        $0.textColor = .white
        $0.textAlignment = .center
        $0.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }

    private let subtitleLabel = UILabel().then {
        $0.text = "앱 내 구입"
        $0.font = .systemFont(ofSize: 12, weight: .regular)
        $0.textColor = .white
        $0.textAlignment = .center
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        
        [titleLabel, subtitleLabel]
            .forEach { addSubview($0) }

        titleLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalToSuperview().inset(8)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.centerX.equalTo(titleLabel.snp.centerX)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
    }
}

// MARK: - PaddedLabel
final class PaddedLabel: UILabel {
    
    var padding: UIEdgeInsets

    init(vertical: CGFloat, horizontal: CGFloat) {
        padding = UIEdgeInsets(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + padding.left + padding.right,
                      height: size.height + padding.top + padding.bottom)
    }
}
