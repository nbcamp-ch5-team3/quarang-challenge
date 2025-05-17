//
//  VideoPlaybackView.swift
//  Presentation
//
//  Created by Quarang on 5/17/25.
//

import UIKit
import AVFoundation

// MARK: - 동영상 재생 플레이어 컴포넌트
final class VideoPlaybackView: UIView {
    private var playerLayer: AVPlayerLayer?
    
    func configure(with url: URL) {
        let player = AVPlayer(url: url)
        let layer = AVPlayerLayer(player: player)
        layer.frame = bounds
        layer.videoGravity = .resizeAspect
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        self.layer.addSublayer(layer)
        self.playerLayer = layer
    }

    func getPlayer() -> AVPlayer? {
        playerLayer?.player
    }
}
