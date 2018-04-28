//
//  ViewController.swift
//  EasyTransitionTVOS
//
//  Created by Julio Carrettoni on 28/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit

struct MovieData {
    let poster: UIImage
    let name: String
    let description: String
    let date: Date

    init(movieId: NSInteger) {
        let availableMoviePosters = 7
        name = "Mock Movie Name \(movieId)"
        description = "Mock Movies Description Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec consequat rutrum risus. Duis ac eros massa. Pellentesque est justo, finibus sit amet odio non, rutrum consequat nulla. Morbi dictum ipsum tempus fringilla laoreet. Phasellus non nulla id augue pellentesque iaculis. Pellentesque et massa mollis diam tempus elementum sit amet at dui. Nunc cursus, ante quis dignissim viverra, metus leo consequat velit, ac tristique lacus justo ac magna. Nam dapibus faucibus velit, at molestie ex fringilla sed. Maecenas interdum pretium pellentesque. Nullam id risus sed nisi consequat aliquam quis ac orci. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Donec suscipit id metus vitae porta. Proin in sollicitudin metus, ut pharetra ex."
        date = Date(timeIntervalSince1970: TimeInterval(Int(drand48()) % 315619200)-1577923199)//Random date between 1920 and 1930
        poster = UIImage(named: "movie\(movieId%availableMoviePosters).jpg")!
    }
}

class MoviePosterCell: UICollectionViewCell {
    static let identifier = "MoviePosterCell"

    @IBOutlet weak var poster: UIImageView!
    var movieData: MovieData!

    func set(with movie: MovieData) {
        movieData = movie
        poster.image = movie.poster
    }

    //This is to keep focused cells from being stuck behind it's siblins
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if let cell = context.nextFocusedView as? UICollectionViewCell {
            cell.superview?.bringSubview(toFront: cell);
        }
    }
}

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var movies: [MovieData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        movies = (1 ... 21).map({ MovieData(movieId: $0) })
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MoviePosterCell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterCell.identifier, for: indexPath) as! MoviePosterCell
        cell.set(with: movies[indexPath.row])
        return cell
    }
}

