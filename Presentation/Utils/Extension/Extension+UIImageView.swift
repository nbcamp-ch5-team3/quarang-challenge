//
//  Extension+UIImageView.swift
//  Presentation
//
//  Created by Quarang on 5/13/25.
//

import UIKit

// MARK: - UIImageView URL load helper (임시)
extension UIImageView {
    
    /// 임의로 색상 뷰를 삽입했다가 이미지 로딩이 끝나면 삭제
    func load(url: URL) {
        let skeletonView = UIView(frame: self.bounds)
        skeletonView.backgroundColor = .systemGray5
        self.addSubview(skeletonView)

        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.image = image
                    skeletonView.removeFromSuperview()
                }
            }
        }
    }
}
