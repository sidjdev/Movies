//
//  General.swift
//  Movies
//
//  Created by Sidharth J Dev on 18/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import Foundation


class Movies {
    static let movieList = MovieListVM()
    static let details = MovieDetailsVM()
    static let movieReviews = MovieReviewsVM()
}

class Logger {
    static func print(_ items: Any...) {
        let separator = " "
        let terminator = "\n"
        var output = items.map { "*\($0)" }.joined(separator: separator)
        #if DEBUG
            output = items.map { "*\($0)" }.joined(separator: separator)
        #else
            output = " "
        #endif
        Swift.print(output, terminator: terminator)
    }
}
