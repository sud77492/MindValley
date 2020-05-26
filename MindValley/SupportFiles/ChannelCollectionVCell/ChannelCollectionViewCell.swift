//
//  ChannelCollectionViewCell.swift
//  MindValley
//
//  Created by Sudhanshu Sharma (HLB) on 25/05/2020.
//  Copyright © 2020 Sudhanshu Sharma (HLB). All rights reserved.
//

import UIKit

class ChannelCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var channelMediaTitle : UILabel!
    @IBOutlet weak var channelMediaImage : UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        channelMediaImage.layer.cornerRadius = 5
        channelMediaImage.layer.masksToBounds = true

    }
    
    public var latestMedia: LatestMedia! {
        didSet {
            self.channelMediaTitle.text = latestMedia.title
            self.channelMediaImage.loadImage(fromURL: latestMedia.coverAsset.url)
        }
    }

}
