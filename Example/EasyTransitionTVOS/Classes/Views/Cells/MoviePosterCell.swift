//
//  MoviePosterCell.swift
//  EasyTransitionTVOS
//
//  Created by Julio Carrettoni on 02/05/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

class MoviePosterCell: UICollectionViewCell {
    static let identifier = "MoviePosterCell"

    @IBOutlet weak var poster: UIImageView!
    var movieData: MovieData? {
        didSet {
            if let movie = movieData {
                poster.image = movie.poster
            }
        }
    }

    //This is to keep focused cells from being stuck behind it's siblins
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let cell = context.nextFocusedView as? UICollectionViewCell {
            cell.superview?.bringSubviewToFront(cell);
        }
    }
}
