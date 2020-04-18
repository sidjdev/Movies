//
//  MovieListModel.swift
//  Movies
//
//  Created by Sidharth J Dev on 18/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import Foundation


class MovieListVM {
    var nowShowing: NowShowingModel? = nil
    
    var api = API()
    func fetchNowShowingList(CompletionHandler: @escaping (String, Bool) -> ()) {
        api.callAPI(APItype: .getMovieList) { (message, status) in
            CompletionHandler(message, status)
            return
        }
    }
}
