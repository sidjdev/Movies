//
//  MovieListView.swift
//  Movies
//
//  Created by Sidharth J Dev on 17/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import UIKit


protocol BookProtocol {
    func clickedBook(for Movie: MovieModel)
}
class MovieListView: UIViewController {

    @IBOutlet weak var moviesTableView: UITableView!
    let movieListVM = MovieListVM()
    var selectedMovie: MovieModel? = nil
    var page = 1
    var searchActive = false
    var searchingText = ""
    fileprivate func setupSearchController() {
        let searchController = UISearchController()
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.searchController = searchController
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        searchController.searchBar.tintColor = .white
        searchController.searchBar.setPlaceholderTextColorTo(color: .white)
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.searchBar.clipsToBounds = true
        
        //for testing
        moviesTableView.accessibilityIdentifier = "movieTable"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNowShowingList()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        let movieListingCellNib = UINib(nibName: "MovieListingCell", bundle: nil)
        moviesTableView.register(movieListingCellNib, forCellReuseIdentifier: "movieListingCell")
        moviesTableView.separatorStyle = .none
        setupSearchController()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController!.navigationBar.largeTitleTextAttributes = [.font: UIFont.systemFont(ofSize: 30, weight: .bold)]
        self.navigationController!.navigationBar.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 18, weight: .bold)]
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
//        movieCell.contentView.layer.borderColor = UIColor.lightGray.cgColor
//        movieCell.contentView.layer.borderWidth = 0.5
//        movieCell.contentView.layer.cornerRadius = 10.0
        movieCell.bookButton.layer.cornerRadius = 10.0
        movieCell.cellData = cellData
        movieCell.bookDelegate = self
        if indexPath.section == tableView.numberOfSections - 1 && !searchActive {
            page += 1
            getNowShowingList(page: page)
        }
        movieCell.accessibilityIdentifier = "cell-\(indexPath.row)"
        return movieCell
    }
}

extension MovieListView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, automaticDimension: Bool = false, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return movieListVM.heightForRow(in: .nowShowing, at: indexPath)
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


extension MovieListView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchActive = searchText == "" ? false : true
        searchingText = searchText
        movieListVM.search(title: searchText) {
            DispatchQueue.main.async {
                self.moviesTableView.reloadData()
            }
        }
    }
   
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.text != "" {
            return false
        }
        return true
    }
}

extension MovieListView: UISearchControllerDelegate {
    func willDismissSearchController(_ searchController: UISearchController) {
        navigationItem.searchController?.searchBar.text = searchingText
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        navigationItem.searchController?.searchBar.text = searchingText
    }
}

extension MovieListView: BookProtocol {
    func clickedBook(for Movie: MovieModel) {
        let title = "\(Movie.title)"
        let body = "We have booked your tickets for \(Movie.title)"
        
        let alertController = UIAlertController(title: title, message: body, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            
        }
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
}
