//
//  ViewController.swift
//  EasyTransitionTVOS
//
//  Created by Julio Carrettoni on 28/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import EasyTransitions

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var movies: [MovieData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        movies = (1 ... 21).map({ MovieData(movieId: $0) })
        definesPresentationContext = true
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MoviePosterCell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterCell.identifier, for: indexPath) as! MoviePosterCell
        cell.movieData = movies[indexPath.row]
        return cell
    }

    private var modalTransitionDelegate = ModalTransitionDelegate()
    private var appStoreAnimator: AppStoreAnimator!
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = MovieDetailViewController()
        detailViewController.movie = movies[indexPath.row]
        guard let cell = collectionView.cellForItem(at: indexPath) as? MoviePosterCell else {
        present(detailViewController, animated: true)
            return
        }

        //We use "focusedFrameGuide" because we want the frame of the cell including the transformation due to the image being focused.
        let cellFrame = view.convert(cell.poster.focusedFrameGuide.layoutFrame, from: cell)

        //We would like the blur to match the current tvOS theme
        let blurEffectStyle: UIBlurEffect.Style = traitCollection.userInterfaceStyle == .light ? .light : .extraDark

        appStoreAnimator = AppStoreAnimator(initialFrame: cellFrame, blurEffectStyle: blurEffectStyle)
        appStoreAnimator.onReady = { cell.isHidden = true }//To improve the ilussion that the cell is moving and not that a new VC is taking it's place.
        appStoreAnimator.onDismissed = { cell.isHidden = false }

        //In this example the same animator works for present and dismiss but we can change that if we want.
        modalTransitionDelegate.set(animator: appStoreAnimator, for: .present)
        modalTransitionDelegate.set(animator: appStoreAnimator, for: .dismiss)

        detailViewController.transitioningDelegate = modalTransitionDelegate
        detailViewController.modalPresentationStyle = .custom

        present(detailViewController, animated: true)
    }

    //We want the blur to always match the current tvOS theme.
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.userInterfaceStyle == .light {
            appStoreAnimator?.blurEffectStyle = .light
        }
        else {
            appStoreAnimator?.blurEffectStyle = .extraDark
        }
    }
}
