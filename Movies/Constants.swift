//
//  Constants.swift
//  Movies
//
//  Created by Sidharth J Dev on 18/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import Foundation


class Constants {
    struct URL {
        static let baseUrl = "https://api.themoviedb.org/3/"
        static let imageBaseUrl = "https://image.tmdb.org/t/p/"
    }
    
    
    struct segue {
        static let home_details = "toMovieDetails"
        static let details_reviews = "toReviews"
    }
    
}
