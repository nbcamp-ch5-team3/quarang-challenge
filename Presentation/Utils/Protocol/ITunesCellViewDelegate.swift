//
//  ITunesCellViewDelegate.swift
//  Presentation
//
//  Created by Quarang on 5/15/25.
//

import Foundation

// MARK: - Cell의 이벤트를 VC에서 처리해주기 위한 Delegate
protocol ITunesCellViewDelegate: AnyObject {
    func didTapDownLoadButton(id: Int)
}
