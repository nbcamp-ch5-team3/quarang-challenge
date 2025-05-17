//
//  ScreenShotCell.swift
//  Presentation
//
//  Created by Quarang on 5/16/25.
//

import UIKit

// MARK: - 스크린샷 셀
final class ScreenshotCell: UICollectionViewCell {
    
    static let identifier = "ScreenshotCell"
    
    private let imageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = 16
        $0.clipsToBounds = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    func configure(with url: URL) {
        imageView.load(url: url)
    }
}
