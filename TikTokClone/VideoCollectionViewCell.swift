//
//  VideoCollectionViewCell.swift
//  TikTokClone
//
//  Created by Nicolas Sieiro on 25/01/2021.
//

import UIKit
import AVFoundation

struct VideoModel {
    let caption: String
    let username: String
    let audioTrackName: String
    let videoFileName: String
    let videoFileFormat: String
}

class VideoCollectionViewCell: UICollectionViewCell {
    var player: AVPlayer?
    static let identifier = "VideoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
        contentView.clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: VideoModel){
        guard let path = Bundle.main.path(forResource: model.videoFileName, ofType: model.videoFileFormat) else {
            return print("Failed to load video path")
        }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        
        let playerView = AVPlayerLayer(player: player)
        playerView.videoGravity = .resizeAspectFill
        playerView.frame = contentView.bounds
        contentView.layer.addSublayer(playerView)
        player?.volume = 0
        player?.play()
    }
}
