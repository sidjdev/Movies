//
//  MovieListModel.swift
//  Movies
//
//  Created by Sidharth J Dev on 18/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import Foundation
import UIKit

class MovieListVM {
    var nowShowing: NowShowingModel? = nil
    var api = API()
    
    enum MovieListTables {
        case nowShowing
    }
    
    
    func fetchNowShowingList(CompletionHandler: @escaping (String, Bool) -> ()) {
        api.callAPI(APItype: .getMovieList) { (message, status) in
            CompletionHandler(message, status)
            return
        }
    }
    
    
    
    func numberOfSections(in tableView: MovieListTables) -> Int {
        switch tableView {
        case .nowShowing:
            return Movies.movieList.nowShowing?.results.count ?? 0
        }
    }
    
    func numberOfRows(in tableView: MovieListTables, In section: Int) -> Int {
        switch tableView {
        case .nowShowing:
            return 1
        }
    }
    
    func heightForRow(in tableView: MovieListTables, at indexPath: IndexPath) -> CGFloat {
        switch tableView {
        case .nowShowing:
            return 125.0
        }
    }
    
    func cellData(for tableView: MovieListTables, at indexPath: IndexPath) -> Any? {
        switch tableView {
        case .nowShowing:
            if let resultData = Movies.movieList.nowShowing?.results[indexPath.section] {
                return resultData
            }
        }
        return nil
    }
}
