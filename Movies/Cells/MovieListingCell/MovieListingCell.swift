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
    let posterSizes: [imageSizeReference : String] = [.small : "w92", .medium : "w342", .large : "w500", .original : "original"]
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
            imageView?.clipsToBounds = true
            imageView?.layer.masksToBounds = true
            let imageName = cellData!.poster_path.replacingOccurrences(of: "*/", with: "")
//            let imageBaseUrl = "https://image.tmdb.org/t/p/"
//            let urlString = imageBaseUrl+posterSizes[.small]!+imageName
//            guard let imageURL = URL(string: urlString) else { return }
//            Nuke.loadImage(with: imageURL, into: moviePoster)
            guard let imageURL = getImageUrl(for: cellData!, at: .small) else { return }
            moviePoster.sd_setImage(with: imageURL, completed: nil)
            
//            let api = API()
//            api.getImage(imageName: imageName, of: posterSizes[.small]!) { (posterImage) in
//                if posterImage != nil {
//                    Logger.print("HERE")
//                }
//                self.moviePoster?.image = posterImage
//            }
            imageView?.layer.cornerRadius = 10.0
            
        }
    }
    
    
    private func getImageUrl(for cellData: MovieModel, at size: imageSizeReference) -> URL? {
        var imageUrl = API.imageBaseUrl
        imageUrl = imageUrl+posterSizes[size]!+cellData.poster_path
        if let url = URL(string: imageUrl) {
            return url
        }
        return nil
    }
}
