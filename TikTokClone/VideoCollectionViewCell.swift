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
        contentView.backgroundColor = .red
        contentView.clipsToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: VideoModel){
        
    }
}
