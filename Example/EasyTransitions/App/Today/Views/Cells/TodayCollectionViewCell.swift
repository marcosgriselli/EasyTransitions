//
//  TodayCollectionViewCell.swift
//  AppStoreTransition
//
//  Created by Marcos Griselli on 18/03/2018.
//  Copyright © 2018 Marcos Griselli. All rights reserved.
//

import UIKit

class TodayCollectionViewCell: UICollectionViewCell, NibLoadableView {

    @IBOutlet weak var cardView: CardView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        set(shadowStyle: .todayCard)
    }
}
