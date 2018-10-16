//
//  CollectionViewController.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 12/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import EasyTransitions

class CollectionViewController: UICollectionViewController {
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 172.5, height: 250)
        layout.sectionInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Collection Elements"
        collectionView?.register(ImageCollectionViewCell.self)
        collectionView?.backgroundColor = UIColor.white
    }
    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let index = (indexPath.item % 6) + 1
        cell.imageView.image = UIImage(named: "detail_\(index)")
        return cell
    }
    
    public func animations(presenting: Bool) -> [AuxAnimation] {
        // Force collectionView to reload and layout. 'Hack'
        if presenting {
            collectionView?.reloadData()
            collectionView?.performBatchUpdates(nil, completion: nil)
        }
        return collectionView!.orderedVisibleCells.enumeratedMap { index, cell in
            let imageCell = cell as! ImageCollectionViewCell
            imageCell.set(layout: presenting ? .converted : .standard)
            let delayFactor = Double(index) * 0.1
            return ({ imageCell.set(layout: presenting ? .standard : .converted) },
                    delayFactor)
        }
    }
}
