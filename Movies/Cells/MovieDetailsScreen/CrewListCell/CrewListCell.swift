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
