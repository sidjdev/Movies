//
//  ReviewResponseModel.swift
//  Movies
//
//  Created by Sidharth J Dev on 18/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import Foundation
import UIKit

struct ReviewResponseModel: Codable {
    var id: Int
    var results: [Review]
    var total_pages: Int
    var total_results: Int
}

struct Review: Codable {
    var author: String
    var content: String
    var id: String
    var url: String
}
