//
//  ChannelTableViewCell.swift
//  MindValley
//
//  Created by Sudhanshu Sharma (HLB) on 24/05/2020.
//  Copyright © 2020 Sudhanshu Sharma (HLB). All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ChannelTableViewCell: UITableViewCell {

    @IBOutlet weak var channelName: UILabel!
    @IBOutlet weak var episodeCount: UILabel!
    @IBOutlet weak var channelImage : UIImageView!
    @IBOutlet weak var channelCollectionView : UICollectionView!
    
    public let latestMedia : PublishSubject<[LatestMedia]> = PublishSubject()
    public let series : PublishSubject<[Series]> = PublishSubject()
    
    private let disposeBag = DisposeBag()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.channelCollectionView.rx.willDisplayCell
            .subscribe(onNext: ({ (cell,indexPath) in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, 0, -250, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: nil)
            })).disposed(by: disposeBag)
        // Initialization code
    }
    
    public var channel : Channel! {
        didSet{
            if channel.series.count > 0{
                self.channelCollectionView.register(UINib(nibName: "SeriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: String(describing: SeriesCollectionViewCell.self))
                //transform Variable to Observable
                
                
                series.bind(to: channelCollectionView.rx.items(cellIdentifier: "SeriesCollectionViewCell", cellType: SeriesCollectionViewCell.self)) { (row,item,cell) in
                    cell.series = item
                }.disposed(by: disposeBag)
                
                series.onNext(channel.series)
            }else{
                self.channelCollectionView.register(UINib(nibName: "ChannelCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: String(describing: ChannelCollectionViewCell.self))
                       
               latestMedia.bind(to: channelCollectionView.rx.items(cellIdentifier: "ChannelCollectionViewCell", cellType: ChannelCollectionViewCell.self)) { (row,item,cell) in
                   cell.latestMedia = item
               }.disposed(by: disposeBag)
                latestMedia.onNext(channel.latestMedia)
            }
            self.channelImage.makeRounded()
            self.channelName.text = channel.title
            self.episodeCount.text = channel.mediaCount > 1 ? String(channel.mediaCount) + " episodes" : String(channel.mediaCount) + " episode"
            self.channelImage.loadImage(fromURL: channel.iconAsset.thumbnailUrl)
          
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
