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

protocol VideoCollectionViewCellDelegate: AnyObject {
    func didTapLikeButton(with model: VideoModel)
    func didTapProfileButton(with model: VideoModel)
    func didTapShareButton(with model: VideoModel)
    func didTapCommentButton(with model: VideoModel)
}

class VideoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "VideoCollectionViewCell"
    var player: AVPlayer?
    var model: VideoModel?
    weak var delegate: VideoCollectionViewCellDelegate?
    
    //UI Elements
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    private let audioLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    private let profileButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName:"person.circle"), for: .normal)
        return button
    }()
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName:"heart.fill"), for: .normal)
        return button
    }()
    private let commentButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName:"text.bubble.fill"), for: .normal)
        return button
    }()
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName:"arrowshape.turn.up.right.fill"), for: .normal)
        return button
    }()
    private let videoContainer = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
        contentView.clipsToBounds = true
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        videoContainer.frame = contentView.bounds
        
        let size = contentView.frame.size.width/7
        let width = contentView.frame.size.width
        let heigth = contentView.frame.size.height-100
        
        shareButton.frame = CGRect(x: width-size, y: heigth-size, width: size, height: size)
        commentButton.frame = CGRect(x: width-size, y: heigth-(size*2)-10, width: size, height: size)
        likeButton.frame = CGRect(x: width-size, y: heigth-(size*3)-10, width: size, height: size)
        profileButton.frame = CGRect(x: width-size, y: heigth-(size*4)-10, width: size, height: size)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clearLabels()
    }
    
    private func clearLabels() {
        captionLabel.text = nil
        audioLabel.text = nil
        usernameLabel.text = nil
    }
    
    private func addSubviews() {
        contentView.addSubview(videoContainer)
        
        contentView.addSubview(usernameLabel)
        contentView.addSubview(captionLabel)
        contentView.addSubview(audioLabel)
        
        contentView.addSubview(profileButton)
        contentView.addSubview(likeButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(commentButton)
        
        //Add actions
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchDown)
        profileButton.addTarget(self, action: #selector(didTapProfileButton), for: .touchDown)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchDown)
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchDown)
        
        videoContainer.clipsToBounds = true
        contentView.sendSubviewToBack(videoContainer)
    }
    
    @objc private func didTapLikeButton() {
        guard let model = model else { return }
        delegate?.didTapLikeButton(with: model)
    }
    
    @objc private func didTapCommentButton() {
        guard let model = model else { return }
        delegate?.didTapCommentButton(with: model)
    }
    
    @objc private func didTapShareButton() {
        guard let model = model else { return }
        delegate?.didTapShareButton(with: model)
    }
    
    @objc private func didTapProfileButton() {
        guard let model = model else { return }
        delegate?.didTapProfileButton(with: model)
    }
    
    private func configureVideo() {
        guard let model = model else { return }
        guard let path = Bundle.main.path(forResource: model.videoFileName, ofType: model.videoFileFormat) else {
            return print("Failed to load video path")
        }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        
        let playerView = AVPlayerLayer()
        playerView.player = player
        playerView.frame = contentView.bounds
        playerView.videoGravity = .resizeAspectFill
        videoContainer.layer.addSublayer(playerView)
        player?.volume = 0
        player?.play()
    }
    
    private func configureLabels() {
        guard let model = model else { return }
        captionLabel.text = model.caption
        audioLabel.text = model.audioTrackName
        usernameLabel.text = model.username
    }
    
    public func configure(with model: VideoModel){
        self.model = model
        configureVideo()
        configureLabels()
    }
    
}
