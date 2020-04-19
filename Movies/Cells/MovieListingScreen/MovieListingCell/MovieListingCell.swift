//
//  MovieListingCell.swift
//  Movies
//
//  Created by Sidharth J Dev on 18/04/20.
//  Copyright © 2020 Sidharth J Dev. All rights reserved.
//

import UIKit
import SDWebImage
import Nuke

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
    enum imageSizeReference {
        case small
        case medium
        case large
        case original
    }
    let backdrop_sizes:[imageSizeReference : String] = [
        .small : "w300",
        .medium : "w780",
        .large : "w1280",
        .original : "original"
    ]
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
            movieName.text = cellData!.original_title
            releaseDate.text = cellData!.release_date
            imageView?.clipsToBounds = true
            imageView?.layer.masksToBounds = true
            guard let imageURL = getImageUrl(for: cellData!, at: .medium) else { return }
            moviePoster.sd_setImage(with: imageURL, completed: nil)
            
            
            
        }
    }
    
    
    private func getImageUrl(for cellData: MovieModel, at size: imageSizeReference) -> URL? {
        var imageUrl = Constants.URL.imageBaseUrl
        imageUrl = imageUrl+backdrop_sizes[size]!+(cellData.backdrop_path ?? "")
        if let url = URL(string: imageUrl) {
            return url
        }
        return nil
    }
}
