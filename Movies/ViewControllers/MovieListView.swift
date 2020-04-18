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
    let movieListVM = MovieListVM()
    override func viewDidLoad() {
        super.viewDidLoad()
        getNowShowingList()
        // Do any additional setup after loading the view.
    }
    
    func getNowShowingList() {
        movieListVM.fetchNowShowingList { (message, status) in
            if status {
                self.moviesTableView.reloadData()
            }
        }
    }
}


extension MovieListView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

