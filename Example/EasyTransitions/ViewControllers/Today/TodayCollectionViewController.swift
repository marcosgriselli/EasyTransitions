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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recalculateItemSizes(givenWidth: self.view.frame.size.width)
    }

    func recalculateItemSizes(givenWidth width: CGFloat) {
        let vcWidth = width - 20//20 is left margin
        var width: CGFloat = 355 //335 is ideal size + 20 of right margin for each item
        let colums = round(vcWidth / width) //Aproximate times the ideal size fits the screen
        width = (vcWidth / colums) - 20 //we substract the right marging
        (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize = CGSize(width: width, height: 412)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        recalculateItemSizes(givenWidth: size.width)

        coordinator.animate(alongsideTransition: nil) { (context) in
            //As the position of the cells might have changed, if we have an AppStoreAnimator, we update it's
            //"initialFrame" so the dimisss animation still matches
            if let animatorInfo = self.animatorInfo {
                if let cell = self.collectionView?.cellForItem(at: animatorInfo.index) {
                    let cellFrame = self.view.convert(cell.frame, from: self.collectionView)
                    animatorInfo.animator.initialFrame = cellFrame
                }
                else {
                    //ups! the cell is not longer on the screen so… ¯\_(ツ)_/¯ lets move it out of the screen
                    animatorInfo.animator.initialFrame = CGRect(x: (size.width-animatorInfo.animator.initialFrame.width)/2.0, y: size.height, width: animatorInfo.animator.initialFrame.width, height: animatorInfo.animator.initialFrame.height)
                }
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
        modalTransitionDelegate.wire(
            viewController: detailViewController,
            with: .regular(.fromTop),
            navigationAction: {
                detailViewController.dismiss(animated: true, completion: nil)       
        })
        
        detailViewController.transitioningDelegate = modalTransitionDelegate
        detailViewController.modalPresentationStyle = .custom
        
        present(detailViewController, animated: true, completion: nil)
        animatorInfo = AppStoreAnimatorInfo(animator: appStoreAnimator, index: indexPath)
    }
}
