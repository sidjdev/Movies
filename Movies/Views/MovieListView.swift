//
//  MovieListView.swift
//  Movies
//
//  Created by Sidharth J Dev on 17/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import UIKit

class MovieListView: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        API().callAPI(params: [:], APItype: .getMovieList, APIMethod: .get) { (message, status) in
            
        }
        // Do any additional setup after loading the view.
    }


}

