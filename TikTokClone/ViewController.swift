//
//  ViewController.swift
//  TikTokClone
//
//  Created by Nicolas Sieiro on 25/01/2021.
//

import UIKit

class ViewController: UIViewController {

    private var collectionView: UICollectionView?
    private var data = [VideoModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in 0..<10 {
            let model = VideoModel(caption: "This is a cool car", username: "NicoS", audioTrackName: "AudioTrack", videoFileName: "video", videoFileFormat: "mmp4")
            data.append(model)
        }
        
        let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        collectionView?.isPagingEnabled = true
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = data[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath) as! VideoCollectionViewCell
        cell.configure(with: model)
        return cell
    }
}

