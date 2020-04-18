//
//  MovieModel.swift
//  Movies
//
//  Created by Sidharth J Dev on 18/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import Foundation


struct MovieModel: Codable {
    var id: Int
    var title: String
    var overview: String
    var release_date: String
    var popularity: Float
    var vote_count: Int
    var video: Bool
    var poster_path: String
    var adult: Bool
    var backdrop_path: String
    var original_language: String
    var original_title: String
    var genre_ids: [Int]
    var vote_average: Float
}


struct NowShowingModel: Codable {
    var results: [MovieModel]
    
    init(data: [MovieModel]) {
        self.results = data
    }
}
