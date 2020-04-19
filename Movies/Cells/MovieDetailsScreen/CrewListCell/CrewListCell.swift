//
//  CrewListCell.swift
//  Movies
//
//  Created by Sidharth J Dev on 18/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import UIKit

class CrewListCell: UITableViewCell {
    @IBOutlet weak var crewCollectionView: UICollectionView!
    
    @IBOutlet weak var cellInfo: UILabel!
    enum DisplayContents {
        case crew
        case similarMovies
    }
    private var _displayContent: DisplayContents = DisplayContents.crew
    var displayContent: DisplayContents {
        set {
            _displayContent = newValue
            setCollectionView()
        }
        get {
           return _displayContent
        }
    }
    var delegate: SimilarMovieProtocol? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let crewCellNib = UINib(nibName: "CrewCell", bundle: nil)
        crewCollectionView.register(crewCellNib, forCellWithReuseIdentifier: "crewCell")
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCollectionView() {
        if displayContent == .crew {
            cellInfo.text = "Crew"
        } else {
            if Movies.details.similarMovies?.results.count == 0 {
                cellInfo.text = ""
            } else {
                cellInfo.text = "Similar Movies"
            }
        }
        DispatchQueue.main.async {
            self.crewCollectionView.reloadData()
        }
    }
}

extension CrewListCell: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch displayContent {
            case .crew:
                return Movies.details.crewList?.cast.count ?? 0
            case .similarMovies:
                return Movies.details.similarMovies?.results.count ?? 0
        
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let crewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "crewCell", for: indexPath) as? CrewCell else { return UICollectionViewCell() }
        switch displayContent {
            case .crew:
                crewCell.crewData = Movies.details.crewList?.cast[indexPath.item]
            case .similarMovies:
                crewCell.movieData = Movies.details.similarMovies?.results[indexPath.item]
        
        }
        return crewCell
    }
    
}

extension CrewListCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CrewCell else {return}
        if self.displayContent == .similarMovies && delegate != nil {
            delegate!.selectedSimilar(movie: cell.movieData)
        }
    }
}
