//
//  MovieListingCell.swift
//  Movies
//
//  Created by Sidharth J Dev on 18/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import UIKit

class MovieListingCell: UITableViewCell {

    @IBOutlet weak var moviePoster: UIImageView!
    
    @IBOutlet weak var movieName: UILabel!
    
    @IBOutlet weak var releaseDate: UILabel!
    
    @IBOutlet weak var bookButton: UIButton!
    
    private var _cellData: MovieModel? = nil
    var cellData: MovieModel? {
        get {
            return _cellData
        }
        set {
            _cellData = newValue
            setContents()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setContents() {
        if cellData != nil {
            movieName.text = cellData!.title
            releaseDate.text = cellData!.release_date
        }
        
    }
    
}
