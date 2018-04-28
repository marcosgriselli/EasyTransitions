//
//  MovieDetailViewController.swift
//  EasyTransitionTVOS
//
//  Created by Julio Carrettoni on 28/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import EasyTransitions

class MovieDetailViewController: UIViewController {

    @IBOutlet var card: UIView!
    @IBOutlet var poster: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieDate: UILabel!
    @IBOutlet var movieDescription: UILabel!

    var movie: MovieData? {
        didSet {
            if let movie = movie, view != nil {
                poster.image = movie.poster
                movieTitle.text = movie.name
                movieDescription.text = movie.description
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .long
                movieDate.text = dateFormatter.string(from: movie.date)
            }
        }
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if traitCollection.userInterfaceStyle == .dark {
            card.backgroundColor = UIColor.darkGray
            movieTitle.textColor = UIColor.white
            movieDate.textColor = UIColor.lightGray
            movieDescription.textColor = UIColor.white
        }
        else {
            card.backgroundColor = UIColor.white
            movieTitle.textColor = UIColor.black
            movieDate.textColor = UIColor.darkGray
            movieDescription.textColor = UIColor.black
        }
    }
}
