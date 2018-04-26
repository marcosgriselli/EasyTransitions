//
//  TodayCollectionViewController.swift
//  AppStoreTransition
//
//  Created by Marcos Griselli on 18/03/2018.
//  Copyright © 2018 Marcos Griselli. All rights reserved.
//

import UIKit
import EasyTransitions

struct AppStoreAnimatorInfo {
    var animator: AppStoreAnimator
    var index: IndexPath
}

class TodayCollectionViewController: UICollectionViewController {

    private var modalTransitionDelegate = ModalTransitionDelegate()
    private var animatorInfo: AppStoreAnimatorInfo?

    // MARK: - Init
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 335, height: 412)
        layout.minimumLineSpacing = 30
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.scrollDirection = .vertical
        super.init(collectionViewLayout: layout)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(TodayCollectionViewCell.self)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let vcWidth = self.view.frame.size.width - 20//20 is left margin
        var width: CGFloat = 355 //335 is ideal size + 20 of right margin for each item
        let colums = round(vcWidth / width) //Aproximate times the ideal size fits the screen
        width = (vcWidth / colums) - 20 //we substract the right marging
        (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize = CGSize(width: width, height: 412)

        //As the position of the cells might have changed, if we have an AppStoreAnimator, we update it's
        //"initialFrame" so the dimisss animation still matches
        if let animatorInfo = animatorInfo {
            if let cell = collectionView?.cellForItem(at: animatorInfo.index) {
                let cellFrame = view.convert(cell.frame, from: collectionView)
                animatorInfo.animator.initialFrame = cellFrame
            }
            else {
                //ups! the cell is not longer on the screen so… ¯\_(ツ)_/¯
            }
        }
    }

    // MARK: - UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: TodayCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        return cell
    }
    
    // MARK: - UICollectionViewDelegate
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let detailViewController = AppDetailViewController()
        
        guard let cell = collectionView.cellForItem(at: indexPath) else {
            present(detailViewController, animated: true, completion: nil)
            return
        }

        let cellFrame = view.convert(cell.frame, from: collectionView)
        
        let appStoreAnimator = AppStoreAnimator(initialFrame: cellFrame)
        appStoreAnimator.onReady = { cell.isHidden = true }
        appStoreAnimator.onDismissed = { cell.isHidden = false }
        appStoreAnimator.auxAnimation = { detailViewController.layout(presenting: $0) }
    
        modalTransitionDelegate.set(animator: appStoreAnimator, for: .present)
        modalTransitionDelegate.set(animator: appStoreAnimator, for: .dismiss)
        modalTransitionDelegate.wire(viewController: detailViewController,
                                     with: .regular(.fromTop))
        
        detailViewController.transitioningDelegate = modalTransitionDelegate
        detailViewController.modalPresentationStyle = .custom
        
        present(detailViewController, animated: true, completion: nil)
        animatorInfo = AppStoreAnimatorInfo(animator: appStoreAnimator, index: indexPath)
    }
}
