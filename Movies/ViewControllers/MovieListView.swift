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
    var selectedMovie: MovieModel? = nil
    var page = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        getNowShowingList()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        let movieListingCellNib = UINib(nibName: "MovieListingCell", bundle: nil)
        moviesTableView.register(movieListingCellNib, forCellReuseIdentifier: "movieListingCell")
        moviesTableView.separatorStyle = .none
        // Do any additional setup after loading the view.
    }
    
    func getNowShowingList(page: Int = 1) {
        movieListVM.fetchNowShowingList(for: page) { (message, status) in
            if status {
                DispatchQueue.main.async {
                    self.moviesTableView.reloadData()
                }
            }
        }
    }
}


extension MovieListView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return movieListVM.numberOfSections(in: .nowShowing)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieListVM.numberOfRows(in: .nowShowing, In: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellData = movieListVM.cellData(for: .nowShowing, at: indexPath) as? MovieModel else {return UITableViewCell()}
        guard let movieCell = tableView.dequeueReusableCell(withIdentifier: "movieListingCell") as? MovieListingCell else { return UITableViewCell() }
        movieCell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        movieCell.contentView.layer.borderWidth = 0.5
        movieCell.contentView.layer.cornerRadius = 10.0
        movieCell.bookButton.layer.cornerRadius = 10.0
        movieCell.cellData = cellData
        if indexPath.section == tableView.numberOfSections - 1 {
            page += 1
            getNowShowingList(page: page)
        }
        
        return movieCell
    }
}

extension MovieListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, automaticDimension: Bool = false, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return automaticDimension ? UITableView.automaticDimension : movieListVM.heightForRow(in: .nowShowing, at: indexPath)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let selectedCell = tableView.cellForRow(at: indexPath) as? MovieListingCell {
            selectedMovie = selectedCell.cellData
        }
        performSegue(withIdentifier: Constants.segue.home_details, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? MovieDetailsView {
            destination.movieDetailsVM = MovieDetailsVM(movie: selectedMovie)
            movieListVM.present(controller: .details, with: destination.movieDetailsVM, from: selectedMovie)
        }
        
    }
}

