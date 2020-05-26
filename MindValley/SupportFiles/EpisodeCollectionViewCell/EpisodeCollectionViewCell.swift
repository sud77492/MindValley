//
//  EpisodeCollectionViewCell.swift
//  MindValley
//
//  Created by Sudhanshu Sharma (HLB) on 20/05/2020.
//  Copyright © 2020 Sudhanshu Sharma (HLB). All rights reserved.
//

import UIKit

import Kingfisher

class EpisodeCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var episodeImage : UIImageView!
    @IBOutlet weak var episodeTitle : UILabel!
    @IBOutlet weak var channelTitle : UILabel!
    
    override func awakeFromNib() {

         episodeImage.layer.cornerRadius = 5
         episodeImage.layer.masksToBounds = true

    }
    
    public var episode: Episode! {
        didSet {
            self.episodeImage.layer.masksToBounds = true
            let url = URL(string: self.episode.coverAsset.url)
            self.episodeImage.kf.setImage(with: url)
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
