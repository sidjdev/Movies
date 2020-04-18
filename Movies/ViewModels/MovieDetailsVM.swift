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
    
    enum DetailsTables {
        case details
    }
    
    func getSynopsis(CompletionHandler: @escaping(String, Bool) -> ()) {
        api.callAPI(APItype: .synopsis, urlComponent: "\(selectedMovie!.id)?") { (message, status) in
            CompletionHandler(message, status)
            return
        }
    }
    
    
    func numberOfSections(in tableView: DetailsTables) -> Int {
        switch tableView {
        case .details:
            return 1
        }
    }
    
    func numberOfRows(in tableView: DetailsTables, In section: Int) -> Int {
        switch tableView {
        case .details:
            return 1
        }
    }
    
    func heightForRow(in tableView: DetailsTables, at indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case .details:
            return 125.0
        }
    }
    
    func cellData(for tableView: DetailsTables, at indexPath: IndexPath) -> Any? {
        switch tableView {
        case .details:
            if let resultData = Movies.details.movieDetails?.overview {
                return resultData
            }
        }
        return nil
    }
    
}
