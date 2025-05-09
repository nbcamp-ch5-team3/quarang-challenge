//
//  MainView.swift
//  Presentation
//
//  Created by Quarang on 5/9/25.
//

import Foundation
import UIKit
internal import SnapKit
internal import Then

// MARK: - 아이튠즈 뷰 
final class ITunesView : UIView {
    
    private let scollView = UIScrollView()
    private let contentView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureAddView() {
        addSubview(scollView)
    }
}
