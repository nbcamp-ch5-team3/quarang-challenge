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

final class ITunesCollectionViewCell: UICollectionViewCell {
    static let identifier = "ITunesCollectionViewCell"

    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
    }

    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.textColor = .label
        $0.numberOfLines = 2
    }

    private let subtitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .regular)
        $0.textColor = .secondaryLabel
        $0.numberOfLines = 1
    }

    private let genreLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .medium)
        $0.textColor = .systemBlue
    }

    private let priceLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 13, weight: .medium)
        $0.textColor = .systemGray
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(genreLabel)
        contentView.addSubview(priceLabel)

        imageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(imageView.snp.width)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }

        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
        }

        genreLabel.snp.makeConstraints {
            $0.top.equalTo(subtitleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview()
        }

        priceLabel.snp.makeConstraints {
            $0.centerY.equalTo(genreLabel.snp.centerY)
            $0.trailing.equalToSuperview()
        }
    }

    func configure(with item: ITunes) {
        imageView.load(url: item.imageURL)
        titleLabel.text = item.title
        subtitleLabel.text = item.subtitle
        genreLabel.text = item.genre
        priceLabel.text = item.priceText
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

