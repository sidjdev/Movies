//
//  DetailsModel.swift
//  Movies
//
//  Created by Sidharth J Dev on 18/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import Foundation


struct DetailsModel: Codable {
    var id: Int
    var tagline: String
    var title: String
    var imdb_id: String
    var original_title: String
    var overview: String
    var adult: Bool
    var backdrop_path: String?
    var genres: [Genre]
    var homepage: String
    var original_language: String
    var popularity: Float
    var poster_path: String
//    var production_companies: [ProductionCompany?]
//    var production_countries: [ProductionCountry?]
    var release_date: String
    var revenue: Float
    var runtime: Int
    var spoken_languages: [SpokenLanguage]
    var status: String?
    var video: Bool = false
    var vote_average: Float?
    var vote_count: Int?
}

struct Genre: Codable {
    var id: Int
    var name: String
}

struct ProductionCompany: Codable {
    var id: Int
    var logo_path: String?
    var name: String
    var origin_country: String
}


struct ProductionCountry: Codable {
    var iso_3166_1: String
    var name: String
}

struct SpokenLanguage: Codable {
    var iso_639_1: String
    var name: String
}
