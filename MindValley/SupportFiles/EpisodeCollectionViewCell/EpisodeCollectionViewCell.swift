//
//  EpisodeCollectionViewCell.swift
//  MindValley
//
//  Created by Sudhanshu Sharma (HLB) on 20/05/2020.
//  Copyright © 2020 Sudhanshu Sharma (HLB). All rights reserved.
//

import UIKit

class EpisodeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var episodeImage : UIImageView!
    @IBOutlet weak var episodeTitle : UILabel!
    @IBOutlet weak var channelTitle : UILabel!
    
    override func awakeFromNib() {

         episodeImage.layer.cornerRadius = 5
         episodeImage.layer.masksToBounds = true

    }
    
    /*var withBackView : Bool! {
        didSet {
            self.backViewGenrator()
        }
    }*/
    /*private lazy var backView: UIImageView = {
        let backView = UIImageView(frame: episodeImage.frame)
        backView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(backView)
        NSLayoutConstraint.activate([
            backView.topAnchor.constraint(equalTo: episodeImage.topAnchor, constant: -10),
            backView.leadingAnchor.constraint(equalTo: episodeImage.leadingAnchor),
            backView.trailingAnchor.constraint(equalTo: episodeImage.trailingAnchor),
            backView.bottomAnchor.constraint(equalTo: episodeImage.bottomAnchor)
        ])
        backView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        backView.alpha = 0.5
        contentView.bringSubviewToFront(episodeImage)
        return backView
    }()*/
    
    public var episode: Episode! {
        didSet {
            self.episodeImage.layer.masksToBounds = true
            self.episodeImage.loadImage(fromURL: episode.coverAsset.url)
            self.episodeTitle.text = episode.title
            self.channelTitle.text = episode.channel.title
        }
    }
    private func backViewGenrator(){
       // backView.loadImage(fromURL: episode.coverAsset.url)
    }
    override func prepareForReuse() {
        episodeImage.image = UIImage()
        //backView.image = UIImage()
    }

}
