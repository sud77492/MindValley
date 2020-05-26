//
//  CategoryCollectionViewCell.swift
//  MindValley
//
//  Created by Sudhanshu Sharma (HLB) on 22/05/2020.
//  Copyright © 2020 Sudhanshu Sharma (HLB). All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryName: UILabel!
    @IBOutlet weak var categoryView : UIView!
    
    public var category: Category! {
        didSet {
            self.categoryView.layer.backgroundColor = UIColor(red: 0.584, green: 0.596, blue: 0.616, alpha: 0.2).cgColor
            self.categoryName.text = category.name
        }
    }
}
