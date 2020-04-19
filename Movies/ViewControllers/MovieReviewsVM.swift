//
//  MovieReviewsVM.swift
//  Movies
//
//  Created by Sidharth J Dev on 18/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import Foundation
import UIKit

class MovieReviewsVM {
    var reviews: ReviewResponseModel? = nil
    var expansionRow: Int = -1
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfRows(in section: Int) -> Int {
        return Movies.movieReviews.reviews?.results.count ?? 0
    }
    
    func heightForRow(at indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func cellData(at indexPath: IndexPath) -> Any? {
        guard let review = Movies.movieReviews.reviews?.results[indexPath.row] else { return nil }
        return review
    }
}
