//
//  MovieDetailsVM.swift
//  Movies
//
//  Created by Sidharth J Dev on 18/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import Foundation


class MovieDetailsVM {
    var selectedMovie: MovieModel? = nil
    let api = API()
    
    
    func getSynopsis() {
        api.callAPI(APItype: .synopsis, urlComponent: "\(selectedMovie!.id)?") { (message, status) in
            
        }
    }
}
