//
//  MovieData.swift
//  EasyTransitionTVOS
//
//  Created by Julio Carrettoni on 02/05/2018.
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
