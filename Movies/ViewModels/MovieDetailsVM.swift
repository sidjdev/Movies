//
//  MovieDetailsVM.swift
//  Movies
//
//  Created by Sidharth J Dev on 18/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import Foundation
import UIKit


class MovieDetailsVM {
    var selectedMovie: MovieModel? = nil
    let api = API()
    var movieDetails: DetailsModel? = nil
    var crewList: CrewModel? = nil
    enum DetailsTables {
        case details
    }
    
    func getSynopsis(CompletionHandler: @escaping(String, Bool) -> ()) {
        api.callAPI(APItype: .synopsis, urlComponent: "\(selectedMovie!.id)?") { (message, status) in
            CompletionHandler(message, status)
            return
        }
    }
    
    func getReviews(CompletionHandler: @escaping(String, Bool) -> ()) {
        api.callAPI(APItype: .getReviews, urlComponent: "\(selectedMovie!.id)/reviews?", pageCount: 1) { (message, status) in
            CompletionHandler(message, status)
            return
        }
    }
    
    func getCrew(CompletionHandler: @escaping(String, Bool) -> ()) {
        api.callAPI(APItype: .getCrew, urlComponent: "\(selectedMovie!.id)/credits?") { (message, status) in
            CompletionHandler(message, status)
            return
        }
    }
    
    
    func numberOfSections(in tableView: DetailsTables) -> Int {
        if tableView == .details {
            return 1
        }
        return 0
    }
    
    func numberOfRows(in tableView: DetailsTables, In section: Int) -> Int {
        if tableView == .details {
            return 4
        }
        return 0
    }
    
    func heightForRow(in tableView: DetailsTables, at indexPath: IndexPath) -> CGFloat {
        if tableView == .details {
            switch indexPath.row {
            case 0:
                return UITableView.automaticDimension
            case 1:
                return Movies.movieReviews.reviews?.total_results == 0 ? 0 : 55.0
                
            case 2:
                return 175.0
            default:
                return 55.0
            }
        }
        return 55.0
    }
    
    func cellData(for tableView: DetailsTables, at indexPath: IndexPath) -> Any? {
        if tableView == .details {
            switch indexPath.row {
            case 0:
                if let resultData = Movies.details.movieDetails?.overview {
                    return resultData
                }
            default:
                return nil
            }
            
        }
        return nil
    }
    
}
