//
//  PaddingLabel.swift
//  Presentation
//
//  Created by Quarang on 5/13/25.
//

import UIKit

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
