//
//  SeriesCollectionViewCell.swift
//  MindValley
//
//  Created by Sudhanshu Sharma (HLB) on 25/05/2020.
//  Copyright © 2020 Sudhanshu Sharma (HLB). All rights reserved.
//

import UIKit

class SeriesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var seriesImage: UIImageView!
    @IBOutlet weak var seriesTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.seriesImage.layer.cornerRadius = 5
        self.seriesImage.layer.masksToBounds = true
    }
    
    public var series: Series! {
        didSet {
            self.seriesTitle.text = series.title
            self.seriesImage.loadImage(fromURL: series.coverAsset.url)
        }
    }

}
