//
//  UICollectionView + OrderedCells.swift
//  EasyTransitions_Example
//
//  Created by Marcos Griselli on 08/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

public extension UICollectionView {
    private func indexPathFor(cell: UICollectionViewCell) -> Int {
        return indexPath(for: cell)?.item ?? -1
    }
    
    var orderedVisibleCells: [UICollectionViewCell] {
        let items = visibleCells
        return items.sorted(by: { indexPathFor(cell: $1) > indexPathFor(cell: $0) })
    }
}
