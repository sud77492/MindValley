//
//  EpisodeVC.swift
//  MindValley
//
//  Created by Sudhanshu Sharma (HLB) on 20/05/2020.
//  Copyright © 2020 Sudhanshu Sharma (HLB). All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class EpisodeVC: UIViewController {
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var mainView: UIView!
    @IBOutlet private weak var tableviewHeight: NSLayoutConstraint!
    @IBOutlet private weak var episodeCollectionView : UICollectionView!
    @IBOutlet private weak var channelCollectionView : UICollectionView!
    @IBOutlet private weak var categoryCollectionView : UICollectionView!
    @IBOutlet private weak var channelTableView : UITableView!
    
    //ViewModel
    var episodeViewModel = EpisodeViewModel()
    var categoryViewModel = CategoryViewModel()
    var channelViewModel = ChannelViewModel()
    
    private let disposeBag = DisposeBag()

    // LifeCycle:
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBinding()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tableviewHeight?.constant = self.channelTableView.contentSize.height
        channelTableView.estimatedRowHeight = 425
    }
    
    private func setupBinding(){
        
        episodeViewModel.loading
        .bind(to: self.rx.isAnimating).disposed(by: disposeBag)
        
        episodeViewModel
        .error
        .observeOn(MainScheduler.instance)
        .subscribe(onNext: { (error) in
            switch error {
            case .internetError(let message):
                MessageView.sharedInstance.showOnView(message: message, theme: .error)
            case .serverMessage(let message):
                MessageView.sharedInstance.showOnView(message: message, theme: .warning)
            }
        })
        .disposed(by: disposeBag)
        
        episodeCollectionView.register(UINib(nibName: "EpisodeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: String(describing: EpisodeCollectionViewCell.self))
        
        episodeViewModel.episodes.bind(to: episodeCollectionView.rx.items(cellIdentifier: "EpisodeCollectionViewCell", cellType: EpisodeCollectionViewCell.self)) { (row,item,cell) in
            cell.episode = item
        }.disposed(by: disposeBag)

        episodeViewModel.requestData()
        
        channelViewModel.channels.bind(to: channelTableView.rx.items(cellIdentifier: "ChannelTableViewCell", cellType: ChannelTableViewCell.self)) { (row,item,cell) in
            print(item.series.count)
            cell.channel = item
        }.disposed(by: disposeBag)
        
        channelViewModel.requestData()
        
        episodeCollectionView.rx.willDisplayCell
        .subscribe(onNext: ({ (cell,indexPath) in
            cell.alpha = 0
            let transform = CATransform3DTranslate(CATransform3DIdentity, 0, -250, 0)
            cell.layer.transform = transform
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                cell.alpha = 1
                cell.layer.transform = CATransform3DIdentity
            }, completion: nil)
        })).disposed(by: disposeBag)
        
        channelTableView
        .rx.setDelegate(self)
        .disposed(by: disposeBag)
        
        categoryViewModel.categories.bind(to: categoryCollectionView.rx.items(cellIdentifier: "CategoryCollectionViewCell", cellType: CategoryCollectionViewCell.self)) { (row,item,cell) in
            cell.category = item
        }.disposed(by: disposeBag)
        categoryViewModel.requestData()
    }
}

extension EpisodeVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row > 2{
            return 320
        }else{
            return 450
        }
    }
}
