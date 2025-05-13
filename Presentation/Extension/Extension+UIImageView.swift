//
//  Extension+UIImageView.swift
//  Presentation
//
//  Created by Quarang on 5/13/25.
//

import UIKit

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
